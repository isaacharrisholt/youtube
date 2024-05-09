//// Functions for interacting with the PokeApi (https://pokeapi.co/).
////
//// Where possible, the results of these functions are parsed into
//// types defined in the `app/pokemon` module, to make it easier to
//// work with the data in the rest of the application.

import gleam/http/request
import gleam/http/response.{type Response}
import gleam/httpc
import gleam/int
import gleam/json
import gleam/list
import gleam/otp/task
import gleam/result
import app/cache.{type Cache}
import app/pokemon.{
  type ApiPokemon, type Move, api_pokemon_decoder, move_decoder,
}

const pokeapi_url = "https://pokeapi.co/api/v2"

/// Make a request to the PokeAPI.
pub fn make_request(path: String) -> Result(Response(String), String) {
  let assert Ok(req) = request.to(pokeapi_url <> path)

  let resp_result =
    httpc.send(req)
    |> result.replace_error("Failed to make request to PokeAPI: " <> path)

  use resp <- result.try(resp_result)

  case resp.status {
    200 -> Ok(resp)
    _ ->
      Error(
        "Got status " <> int.to_string(resp.status) <> " from PokeAPI: " <> path,
      )
  }
}

/// Get a Pokemon by its name from the PokeAPI
///
/// Note: this function doesn't use the cache, as it returns an ApiPokemon,
/// which doesn't have all associated move data. We cache the moves separately
/// to avoid making multiple requests for the same move, and then cache
/// the full Pokemon data later.
pub fn get_pokemon(name: String) -> Result(ApiPokemon, String) {
  use resp <- result.try(make_request("/pokemon/" <> name))

  case json.decode(from: resp.body, using: api_pokemon_decoder()) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> Error("Failed to decode Pokemon")
  }
}

/// Get a move by its name from the PokeAPI.
/// Will also cache the move in the provided cache.
pub fn get_move(name: String, move_cache: Cache(Move)) -> Result(Move, String) {
  case cache.get(move_cache, name) {
    Ok(move) -> Ok(move)
    Error(_) -> {
      use resp <- result.try(make_request("/move/" <> name))

      case json.decode(from: resp.body, using: move_decoder()) {
        Ok(move) -> {
          cache.set(move_cache, name, move)
          Ok(move)
        }
        Error(_) -> Error("Failed to decode Move")
      }
    }
  }
}

/// Get all moves for a Pokemon.
/// Returns the first error encountered, if any.
pub fn get_moves_for_pokemon(
  api_pokemon: ApiPokemon,
  move_cache: Cache(Move),
) -> Result(List(Move), String) {
  let results =
    list.map(api_pokemon.moves, fn(move) {
      task.async(fn() { get_move(move.move.name, move_cache) })
    })
    |> list.map(fn(handle) {
      task.try_await(handle, 3000)
      |> result.replace_error("Failed to fetch move")
      |> result.flatten
    })
    |> result.partition

  case results.1 {
    [] -> Ok(results.0)
    [err, ..] -> Error("Error fetching moves: " <> err)
  }
}
