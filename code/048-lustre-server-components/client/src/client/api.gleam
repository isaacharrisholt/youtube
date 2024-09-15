import gleam/dynamic
import gleam/string
import lustre/effect
import lustre_http.{type HttpError}
import shared/pokemon.{type Pokemon, pokemon_decoder}

const api_root = "http://localhost:8000"

pub type CanLoad(value, error) {
  Loading
  Loaded(value)
  LoadError(error)
}

pub fn fetch_pokemon(
  search: String,
  on_result_msg: fn(Result(Pokemon, HttpError)) -> a,
) -> effect.Effect(a) {
  let expect = lustre_http.expect_json(pokemon_decoder(), on_result_msg)
  lustre_http.get(api_root <> "/pokemon/" <> string.lowercase(search), expect)
}

pub fn fetch_all_pokemon(
  on_result_msg: fn(Result(List(String), HttpError)) -> a,
) -> effect.Effect(a) {
  let expect =
    lustre_http.expect_json(dynamic.list(dynamic.string), on_result_msg)
  lustre_http.get(api_root <> "/pokemon", expect)
}
