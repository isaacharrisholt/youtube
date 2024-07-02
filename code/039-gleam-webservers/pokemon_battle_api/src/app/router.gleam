//// Routes defined in our application.
////
//// We use a single handler for all requests, and route the request
//// based on the path segments. This allows us to keep all of our
//// application logic in one place, and to easily add new routes.

import gleam/json
import gleam/result
import wisp.{type Request, type Response}
import app/battle
import app/cache
import app/context.{type Context}
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import app/pokemon.{Pokemon, encode_pokemon}

/// Route the request to the appropriate handler based on the path segments.
pub fn handle_request(req: Request, ctx: Context) -> Response {
  case wisp.path_segments(req) {
    // Health check
    [] -> wisp.ok()
    // /pokemon/:name
    ["pokemon", name] -> get_pokemon_handler(ctx, name)
    // /battle/:name1/:name2
    ["battle", name1, name2] -> get_battle_handler(ctx, name1, name2)
    // Any non-matching routes
    _ -> wisp.not_found()
  }
}

/// Fetch a Pokemon from the PokeAPI.
///
/// Will also fetch the moves for the Pokemon, and cache the result.
fn fetch_pokemon(ctx: Context, name: String) {
  case cache.get(ctx.pokemon_cache, name) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon <- result.try(get_pokemon(name))
      use moves <- result.try(get_moves_for_pokemon(pokemon, ctx.move_cache))
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

/// Handler for the /pokemon/:name route.
/// Fetches the requested Pokemon, encodes it as JSON, and returns it.
fn get_pokemon_handler(ctx: Context, name: String) -> Response {
  case fetch_pokemon(ctx, name) {
    Ok(pokemon) -> {
      encode_pokemon(pokemon)
      |> json.to_string_builder
      |> wisp.json_response(200)
    }
    Error(msg) -> error_response(msg)
  }
}

/// Handler for the /battle/:name1/:name2 route.
/// Fetches both Pokemon, battles them, and returns the winner.
fn get_battle_handler(ctx: Context, name1: String, name2: String) {
  let existing =
    cache.create_composite_key([name1, name2])
    |> cache.get(ctx.battle_cache, _)
  let result = case existing {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon1 <- result.try(fetch_pokemon(ctx, name1))
      use pokemon2 <- result.try(fetch_pokemon(ctx, name2))

      case battle.battle(pokemon1, pokemon2) {
        Ok(winner) -> {
          cache.create_composite_key([name1, name2])
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
    Error(msg) -> error_response(msg)
  }
}

/// Create an error response from a message.
fn error_response(msg: String) -> Response {
  json.object([#("error", json.string(msg))])
  |> json.to_string_builder
  |> wisp.json_response(500)
}
