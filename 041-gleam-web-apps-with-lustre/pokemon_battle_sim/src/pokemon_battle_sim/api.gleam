import gleam/string
import lustre/effect
import lustre_http
import pokemon_battle_sim/types/msg.{type Msg, ApiReturnedPokemon}
import pokemon_battle_sim/types/pokemon.{pokemon_decoder}

const api_root = "http://localhost:8000"

pub fn fetch_pokemon(search: String) -> effect.Effect(Msg) {
  let expect = lustre_http.expect_json(pokemon_decoder(), ApiReturnedPokemon)
  lustre_http.get(api_root <> "/pokemon/" <> string.lowercase(search), expect)
}
