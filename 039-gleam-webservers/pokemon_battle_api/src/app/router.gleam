import wisp.{type Request, type Response}
import gleam/io
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result
import app/context.{type Context}
import app/pokemon.{PokemonWithMoves}
import app/cache
import app/battle
import gleam/dynamic

pub fn handle_request(req: Request, ctx: Context) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    ["pokemon", name] -> get_pokemon_handler(name, ctx)
    ["battle", name1, name2] -> get_battle_handler(name1, name2, ctx)
    _ -> wisp.not_found()
  }
}

fn fetch_pokemon(name: String, ctx: Context) {
  case cache.get(ctx.pokemon_cache, name) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon <- result.try(get_pokemon(name))
      let moves = get_moves_for_pokemon(pokemon, ctx.move_cache)
      Ok(PokemonWithMoves(pokemon, moves))
    }
  }
}

fn get_pokemon_handler(name: String, ctx: Context) -> Response {
  case fetch_pokemon(name, ctx) {
    Ok(pokemon) -> {
      io.debug(pokemon)
      wisp.ok()
    }
    Error(_) -> wisp.not_found()
  }
}

fn get_battle_handler(name1: String, name2: String, ctx) {
  let result = {
    use pokemon1 <- result.try(fetch_pokemon(name1, ctx))
    use pokemon2 <- result.try(fetch_pokemon(name2, ctx))

    result.map_error(battle.battle(pokemon1, pokemon2), fn(_) {
      dynamic.from(Nil)
    })
  }
  case result {
    Ok(pokemon) -> {
      io.debug("Winner: " <> pokemon.pokemon.name)
      wisp.ok()
    }
    Error(_) -> wisp.internal_server_error()
  }
}
