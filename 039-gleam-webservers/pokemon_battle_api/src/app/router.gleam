import wisp.{type Request, type Response}
// import gleam/io
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result
import app/context.{type Context}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    ["pokemon", name] -> get_pokemon_handler(name, ctx)
    _ -> wisp.not_found()
  }
}

fn get_pokemon_handler(name: String, ctx: Context) -> Response {
  let result = {
    use pokemon <- result.try(get_pokemon(name, ctx.pokemon_cache))
    let moves = get_moves_for_pokemon(pokemon, ctx.move_cache)
    // io.debug(moves)
    Ok(pokemon)
  }
  case result {
    Ok(pokemon) -> {
      // io.debug(pokemon)
      wisp.ok()
    }
    Error(_) -> wisp.not_found()
  }
}
