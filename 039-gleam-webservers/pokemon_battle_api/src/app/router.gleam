import wisp.{type Request, type Response}
import gleam/json
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import gleam/result
import app/context.{type Context}
import app/pokemon.{Pokemon, encode_pokemon}
import app/cache
import app/battle

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
      let pokemon_with_moves =
        Pokemon(
          id: pokemon.id,
          name: pokemon.name,
          base_experience: pokemon.base_experience,
          base_stats: pokemon.base_stats,
          moves: moves,
        )
      cache.set(ctx.pokemon_cache, name, pokemon_with_moves)
      Ok(pokemon_with_moves)
    }
  }
}

fn get_pokemon_handler(ctx: Context, name: String) -> Response {
  case fetch_pokemon(ctx, name) {
    Ok(pokemon) -> {
      encode_pokemon(pokemon)
      |> json.to_string_builder
      |> wisp.json_response(200)
    }
    Error(msg) -> {
      json.object([#("error", json.string(msg))])
      |> json.to_string_builder
      |> wisp.json_response(500)
    }
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

      case battle.battle(pokemon1, pokemon2) {
        Ok(winner) -> {
          cache.get_composite_key([name1, name2])
          |> cache.set(ctx.battle_cache, _, winner)
          Ok(winner)
        }
        Error(_) -> Error("Failed to battle " <> name1 <> " vs " <> name2)
      }
    }
  }
  case result {
    Ok(pokemon) -> {
      json.object([#("winner", json.string(pokemon.name))])
      |> json.to_string_builder
      |> wisp.json_response(200)
    }
    Error(msg) -> {
      json.object([#("error", json.string(msg))])
      |> json.to_string_builder
      |> wisp.json_response(500)
    }
  }
}
