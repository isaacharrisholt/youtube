import wisp.{type Request, type Response}
import gleam/io
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result
import app/context.{type Context}
import app/pokemon.{PokemonWithMoves}
import app/cache

pub fn handle_request(req: Request, ctx: Context) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    ["pokemon", name] -> get_pokemon_handler(name, ctx)
    _ -> wisp.not_found()
  }
}

fn get_pokemon_handler(name: String, ctx: Context) -> Response {
  let pokemon_result = case cache.get(ctx.pokemon_cache, name) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon <- result.try(get_pokemon(name))
      let moves = get_moves_for_pokemon(pokemon, ctx.move_cache)
      Ok(PokemonWithMoves(pokemon, moves))
    }
  }
  case pokemon_result {
    Ok(pokemon) -> {
      io.debug(pokemon)
      wisp.ok()
    }
    Error(_) -> wisp.not_found()
  }
}
