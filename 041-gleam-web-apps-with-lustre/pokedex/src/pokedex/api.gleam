import gleam/dynamic
import gleam/string
import lustre/effect
import lustre_http
import pokedex/types/msg.{
  type Msg, ApiReturnedAllPokemon, ApiReturnedPokemon,
}
import pokedex/types/pokemon.{pokemon_decoder}

const api_root = "http://localhost:8000"

pub fn fetch_pokemon(search: String) -> effect.Effect(Msg) {
  let expect = lustre_http.expect_json(pokemon_decoder(), ApiReturnedPokemon)
  lustre_http.get(api_root <> "/pokemon/" <> string.lowercase(search), expect)
}

pub fn fetch_all_pokemon() -> effect.Effect(Msg) {
  let expect =
    lustre_http.expect_json(dynamic.list(dynamic.string), ApiReturnedAllPokemon)
  lustre_http.get(api_root <> "/pokemon", expect)
}
