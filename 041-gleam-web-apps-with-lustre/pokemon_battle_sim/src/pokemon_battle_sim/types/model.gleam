import gleam/option.{type Option}
import pokemon_battle_sim/types.{type CanLoad}
import pokemon_battle_sim/types/pokemon.{type Pokemon}

pub type Model {
  Model(
    current_pokemon: CanLoad(Option(Pokemon), String),
    all_pokemon: CanLoad(List(String), String),
    battle_pair: Option(#(String, String)),
  )
}
