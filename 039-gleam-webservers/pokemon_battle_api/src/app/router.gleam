import wisp.{type Request, type Response}
import gleam/io
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result

pub fn handle_request(req: Request) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    ["pokemon", name] -> get_pokemon_handler(name)
    _ -> wisp.not_found()
  }
}

fn get_pokemon_handler(name: String) -> Response {
  let result = {
    use pokemon <- result.try(get_pokemon(name))
    let moves = get_moves_for_pokemon(pokemon)
    io.debug(moves)
    Ok(pokemon)
  }
  case result {
    Ok(pokemon) -> {
      io.debug(pokemon)
      wisp.ok()
    }
    Error(_) -> wisp.not_found()
  }
}
