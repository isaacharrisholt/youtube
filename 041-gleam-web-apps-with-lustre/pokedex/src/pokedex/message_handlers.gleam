import gleam/list
import gleam/option.{Some}
import gleam/string
import lustre/effect
import plinth/browser/document
import plinth/browser/element as browser_element
import pokedex/api.{fetch_all_pokemon, fetch_pokemon}
import pokedex/dom
import pokedex/types/model.{type Model, Model}
import pokedex/types/msg.{type Msg, Loaded, Loading}
import pokedex/types/pokemon.{type Pokemon}
import pokedex/views.{pokemon_search_input_id}

pub fn handle_user_selected_pokemon(
  model: Model,
  pokemon_name: String,
) -> #(Model, effect.Effect(Msg)) {
  let default_return = #(
    Model(..model, current_pokemon: Loading),
    fetch_pokemon(pokemon_name),
  )
  case model.current_pokemon {
    Loaded(Some(current_pokemon)) -> {
      case current_pokemon.name == pokemon_name {
        True -> #(model, effect.none())
        False -> default_return
      }
    }
    _ -> default_return
  }
}

pub fn handle_user_clicked_search_button(
  model: Model,
) -> #(Model, effect.Effect(Msg)) {
  let assert Ok(search_element) =
    document.query_selector("#" <> pokemon_search_input_id)
  let assert Ok(pokemon_name) = browser_element.value(search_element)
  let cleaned_pokemon_name =
    pokemon_name
    |> string.trim
    |> string.lowercase
  case string.trim(cleaned_pokemon_name) {
    "" -> #(model, effect.none())
    cleaned -> {
      dom.set_value(search_element, "")
      handle_user_selected_pokemon(model, cleaned)
    }
  }
}

pub fn handle_api_returned_pokemon_ok(
  model: Model,
  pokemon: Pokemon,
) -> #(Model, effect.Effect(Msg)) {
  let default_return = #(
    Model(..model, current_pokemon: Loaded(Some(pokemon))),
    effect.none(),
  )
  case model.all_pokemon {
    Loaded(pokemon_names) -> {
      case list.contains(pokemon_names, pokemon.name) {
        // If the pokemon is not in the list, we need to fetch the list again
        False -> #(default_return.0, fetch_all_pokemon())
        // If it is, we just update the current pokemon as before
        True -> default_return
      }
    }
    _ -> default_return
  }
}
