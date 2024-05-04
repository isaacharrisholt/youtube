import wisp.{type Request, type Response}
import gleam/json
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result
import app/context.{type Context}
import app/pokemon.{PokemonWithMoves, encode_pokemon_with_moves}
import app/cache
import app/battle
import gleam/dynamic

pub fn handle_request(req: Request, ctx: Context) -> Response {
  case wisp.path_segments(req) {
    [] -> wisp.ok()
    ["pokemon", name] -> get_pokemon_handler(ctx, name)
    ["battle", name1, name2] -> get_battle_handler(ctx, name1, name2)
    _ -> wisp.not_found()
  }
}

fn fetch_pokemon(ctx: Context, name: String) {
  case cache.get(ctx.pokemon_cache, name) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon <- result.try(get_pokemon(name))
      let moves = get_moves_for_pokemon(pokemon, ctx.move_cache)
      Ok(PokemonWithMoves(pokemon, moves))
    }
  }
}

fn get_pokemon_handler(ctx: Context, name: String) -> Response {
  case fetch_pokemon(ctx, name) {
    Ok(pokemon) -> {
      encode_pokemon_with_moves(pokemon)
      |> json.to_string_builder
      |> wisp.json_response(200)
    }
    Error(_) -> wisp.not_found()
  }
}

fn get_battle_handler(ctx: Context, name1: String, name2: String) {
  let existing =
    cache.get_composite_key([name1, name2])
    |> cache.get(ctx.battle_cache, _)
  let result = case existing {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon1 <- result.try(fetch_pokemon(ctx, name1))
      use pokemon2 <- result.try(fetch_pokemon(ctx, name2))

      result.map_error(battle.battle(pokemon1, pokemon2), fn(_) {
        dynamic.from(Nil)
      })
    }
  }
  case result {
    Ok(pokemon) -> {
      json.object([#("winner", json.string(pokemon.pokemon.name))])
      |> json.to_string_builder
      |> wisp.json_response(200)
    }
    Error(_) -> wisp.internal_server_error()
  }
}
