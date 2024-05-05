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

/// Make a request to the PokeAPI
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
pub fn get_pokemon(name: String) -> Result(ApiPokemon, String) {
  use resp <- result.try(make_request("/pokemon/" <> name))

  case json.decode(from: resp.body, using: api_pokemon_decoder()) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> Error("Failed to decode Pokemon")
  }
}

/// Get a move by its name from the PokeAPI
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

/// Get all moves for a Pokemon
pub fn get_moves_for_pokemon(
  api_pokemon: ApiPokemon,
  move_cache: Cache(Move),
) -> List(Move) {
  let handles =
    list.map(api_pokemon.moves, fn(move) {
      task.async(fn() {
        let assert Ok(move) = get_move(move.move.name, move_cache)
        move
      })
    })
  list.map(handles, fn(handle) { task.await(handle, 3000) })
}
