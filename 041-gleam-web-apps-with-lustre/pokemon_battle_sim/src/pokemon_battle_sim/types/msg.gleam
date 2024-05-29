import lustre_http
import pokemon_battle_sim/types/pokemon.{type Pokemon}

pub type Msg {
  UserSelectedPokemon(String)
  ApiReturnedPokemon(Result(Pokemon, lustre_http.HttpError))
}
