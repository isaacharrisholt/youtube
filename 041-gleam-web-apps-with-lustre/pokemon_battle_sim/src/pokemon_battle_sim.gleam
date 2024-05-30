import gleam/option.{None, Some}
import gleam/string
import lustre
import lustre/effect
import lustre/element
import lustre/ui
import lustre/ui/util/styles
import plinth/browser/document
import plinth/browser/element as browser_element
import pokemon_battle_sim/api.{fetch_pokemon}
import pokemon_battle_sim/dom
import pokemon_battle_sim/types.{LoadError, Loaded, Loading}
import pokemon_battle_sim/types/model.{type Model, Model}
import pokemon_battle_sim/types/msg.{
  type Msg, ApiReturnedPokemon, UserClickedSearchButton, UserSelectedPokemon,
}
import pokemon_battle_sim/views.{header, main_content, pokemon_search_input_id}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(
      current_pokemon: Loaded(None),
      all_pokemon: Loaded(["Pikachu", "Turtwig", "Chimchar", "Piplup", "Zorua"]),
      battle_pair: None,
    ),
    effect.none(),
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

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserSelectedPokemon(pokemon_name) ->
      handle_user_selected_pokemon(model, pokemon_name)
    UserClickedSearchButton -> handle_user_clicked_search_button(model)
    ApiReturnedPokemon(Ok(pokemon)) -> #(
      Model(..model, current_pokemon: Loaded(Some(pokemon))),
      effect.none(),
    )
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
