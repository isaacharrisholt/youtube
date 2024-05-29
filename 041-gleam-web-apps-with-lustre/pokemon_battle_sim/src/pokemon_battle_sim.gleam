import gleam/io
import gleam/option.{None, Some}
import gleam/string
import lustre
import lustre/attribute
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/ui
import lustre/ui/util/styles
import pokemon_battle_sim/api.{fetch_pokemon}
import pokemon_battle_sim/types/model.{type Model, Model}
import pokemon_battle_sim/types/msg.{
  type Msg, ApiReturnedPokemon, UserSelectedPokemon,
}

import pokemon_battle_sim/views.{header, main_content}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(
      current_pokemon: None,
      all_pokemon: ["Pikachu", "Turtwig", "Chimchar", "Piplup", "Zorua"],
      battle_pair: None,
    ),
    effect.none(),
  )
}

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserSelectedPokemon(pokemon_name) -> #(model, fetch_pokemon(pokemon_name))
    ApiReturnedPokemon(Ok(pokemon)) -> #(
      Model(..model, current_pokemon: Some(pokemon)),
      effect.none(),
    )
    ApiReturnedPokemon(Error(err)) -> {
      io.println("Error fetching Pokemon: " <> string.inspect(err))
      #(model, effect.none())
    }
  }
}

fn view(model: Model) -> element.Element(Msg) {
  ui.stack([], [
    styles.elements(),
    html.link([
      attribute.rel("stylesheet"),
      attribute.href("./priv/static/pokemon_battle_sim.css"),
    ]),
    header(),
    main_content(model),
  ])
}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
