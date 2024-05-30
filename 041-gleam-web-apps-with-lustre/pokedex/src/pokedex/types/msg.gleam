import lustre_http
import pokedex/types/pokemon.{type Pokemon}

pub type Msg {
  UserSelectedPokemon(String)
  UserClickedSearchButton

  ApiReturnedPokemon(Result(Pokemon, lustre_http.HttpError))
  ApiReturnedAllPokemon(Result(List(String), lustre_http.HttpError))

  AppRequestedAllPokemon
}
