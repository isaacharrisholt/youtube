import gleam/option.{None, Some}
import gleam/string
import lustre
import lustre/effect
import lustre/element
import lustre/ui
import lustre/ui/util/styles
import pokemon_battle_sim/api.{fetch_pokemon}
import pokemon_battle_sim/types.{LoadError, Loaded, Loading}
import pokemon_battle_sim/types/model.{type Model, Model}
import pokemon_battle_sim/types/msg.{
  type Msg, ApiReturnedPokemon, UserSelectedPokemon,
}

import pokemon_battle_sim/views.{header, main_content}

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

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserSelectedPokemon(pokemon_name) ->
      handle_user_selected_pokemon(model, pokemon_name)
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
