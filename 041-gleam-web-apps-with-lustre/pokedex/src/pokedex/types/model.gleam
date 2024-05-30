import gleam/option.{type Option}
import pokedex/types.{type CanLoad}
import pokedex/types/pokemon.{type Pokemon}

pub type Model {
  Model(
    current_pokemon: CanLoad(Option(Pokemon), String),
    all_pokemon: CanLoad(List(String), String),
  )
}
