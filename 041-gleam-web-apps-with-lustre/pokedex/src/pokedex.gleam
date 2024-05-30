import gleam/list
import gleam/option.{None, Some}
import gleam/string
import lustre
import lustre/effect
import lustre/element
import lustre/ui
import lustre/ui/util/styles
import plinth/browser/document
import plinth/browser/element as browser_element
import pokedex/api.{fetch_all_pokemon, fetch_pokemon}
import pokedex/dom
import pokedex/types.{LoadError, Loaded, Loading}
import pokedex/types/model.{type Model, Model}
import pokedex/types/msg.{
  type Msg, ApiReturnedAllPokemon, ApiReturnedPokemon, AppRequestedAllPokemon,
  UserClickedSearchButton, UserSelectedPokemon,
}
import pokedex/types/pokemon.{type Pokemon}
import pokedex/views.{header, main_content, pokemon_search_input_id}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(current_pokemon: Loaded(None), all_pokemon: Loading),
    fetch_all_pokemon(),
  )
}

fn handle_user_selected_pokemon(
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

fn handle_user_clicked_search_button(
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

fn handle_api_returned_pokemon_ok(
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

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserSelectedPokemon(pokemon_name) ->
      handle_user_selected_pokemon(model, pokemon_name)
    UserClickedSearchButton -> handle_user_clicked_search_button(model)

    AppRequestedAllPokemon -> #(
      Model(..model, all_pokemon: Loading),
      fetch_all_pokemon(),
    )

    ApiReturnedPokemon(Ok(pokemon)) ->
      handle_api_returned_pokemon_ok(model, pokemon)
    ApiReturnedPokemon(Error(err)) -> {
      #(
        Model(
          ..model,
          current_pokemon: LoadError(
            "Error fetching Pokemon: " <> string.inspect(err),
          ),
        ),
        effect.none(),
      )
    }

    ApiReturnedAllPokemon(Ok(pokemon_names)) -> #(
      Model(
        ..model,
        all_pokemon: Loaded(
          pokemon_names
          |> list.sort(string.compare),
        ),
      ),
      effect.none(),
    )
    ApiReturnedAllPokemon(Error(err)) -> {
      #(
        Model(
          ..model,
          all_pokemon: LoadError(
            "Error fetching Pokemon: " <> string.inspect(err),
          ),
        ),
        effect.none(),
      )
    }
  }
}

fn view(model: Model) -> element.Element(Msg) {
  ui.stack([], [styles.elements(), header(), main_content(model)])
}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
