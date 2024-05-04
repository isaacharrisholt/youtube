import gleam/httpc
import gleam/http/request
import gleam/result
import gleam/json
import gleam/dynamic
import app/pokemon.{type Move, type Pokemon, move_decoder, pokemon_decoder}
import gleam/list
import gleam/otp/task

const pokeapi_url = "https://pokeapi.co/api/v2/"

/// Get a Pokemon by its name from the PokeAPI
pub fn get_pokemon(name: String) -> Result(Pokemon, dynamic.Dynamic) {
  let assert Ok(req) = request.to(pokeapi_url <> "pokemon/" <> name)

  use resp <- result.try(httpc.send(req))

  case json.decode(from: resp.body, using: pokemon_decoder()) {
    Ok(pokemon) -> Ok(pokemon)
    Error(err) -> Error(dynamic.from(err))
  }
}

/// Get a move by its name from the PokeAPI
pub fn get_move(name: String) -> Result(Move, dynamic.Dynamic) {
  let assert Ok(req) = request.to(pokeapi_url <> "move/" <> name)

  use resp <- result.try(httpc.send(req))

  case json.decode(from: resp.body, using: move_decoder()) {
    Ok(move) -> Ok(move)
    Error(err) -> Error(dynamic.from(err))
  }
}

/// Get all moves for a Pokemon
pub fn get_moves_for_pokemon(pokemon: Pokemon) -> List(Move) {
  let handles =
    list.map(pokemon.moves, fn(move) {
      task.async(fn() {
        let assert Ok(move) = get_move(move.move.name)
        move
      })
    })
  list.map(handles, fn(handle) { task.await(handle, 3000) })
}
