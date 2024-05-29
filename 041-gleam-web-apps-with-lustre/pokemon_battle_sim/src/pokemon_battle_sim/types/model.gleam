import gleam/option.{type Option}
import pokemon_battle_sim/types/pokemon.{type Pokemon}

pub type Model {
  Model(
    current_pokemon: Option(Pokemon),
    all_pokemon: List(String),
    battle_pair: Option(#(String, String)),
  )
}
