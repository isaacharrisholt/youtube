//// Routes defined in our application.
////
//// We use a single handler for all requests, and route the request
//// based on the path segments. This allows us to keep all of our
//// application logic in one place, and to easily add new routes.

import app/battle
import app/cache
import app/context.{type Context}
import app/pokeapi.{get_moves_for_pokemon, get_pokemon}
import app/pokemon.{Pokemon, encode_pokemon}
import client.{Model}
import client/api.{Loaded}
import gleam/http.{Options}
import gleam/json
import gleam/option.{None}
import gleam/result
import lustre/attribute
import lustre/element
import lustre/element/html.{html}
import wisp.{type Request, type Response}

fn cors_middleware(req: Request, fun: fn() -> Response) -> Response {
  case req.method {
    Options -> {
      wisp.response(200)
      |> wisp.set_header("Access-Control-Allow-Origin", "*")
      |> wisp.set_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
      |> wisp.set_header("Access-Control-Allow-Headers", "Content-Type")
    }
    _ -> {
      fun()
      |> wisp.set_header("Access-Control-Allow-Origin", "*")
      |> wisp.set_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
      |> wisp.set_header("Access-Control-Allow-Headers", "Content-Type")
    }
  }
}

fn static_middleware(req: Request, fun: fn() -> Response) -> Response {
  let assert Ok(priv) = wisp.priv_directory("server")
  wisp.serve_static(req, under: "/static", from: priv, next: fun)
}

/// Route the request to the appropriate handler based on the path segments.
pub fn handle_request(req: Request, ctx: Context) -> Response {
  use <- cors_middleware(req)
  use <- static_middleware(req)
  case wisp.path_segments(req) {
    // Home
    [] -> home(ctx)
    // /pokemon
    ["pokemon"] -> get_all_pokemon_handler(ctx)
    // /pokemon/:name
    ["pokemon", name] -> get_pokemon_handler(ctx, name)
    // /battle/:name1/:name2
    ["battle", name1, name2] -> get_battle_handler(ctx, name1, name2)
    // Any non-matching routes
    _ -> wisp.not_found()
  }
}

fn page_scaffold(
  content: element.Element(a),
  init_json: String,
) -> element.Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.attribute("charset", "UTF-8")]),
      html.meta([
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
        attribute.name("viewport"),
      ]),
      html.title([], "Pokedex"),
      html.script(
        [attribute.src("/static/client.mjs"), attribute.type_("module")],
        "",
      ),
      html.script(
        [attribute.type_("application/json"), attribute.id("model")],
        init_json,
      ),
      html.link([
        attribute.href("/static/client.css"),
        attribute.rel("stylesheet"),
      ]),
    ]),
    html.body([], [html.div([attribute.id("app")], [content])]),
  ])
}

fn encode_all_pokemon(all_pokemon: List(String)) -> String {
  json.array(all_pokemon, json.string)
  |> json.to_string
}

fn home(ctx: Context) -> Response {
  let all_pokemon = cache.get_keys(ctx.pokemon_cache)
  let model =
    Model(
      all_pokemon: Loaded(all_pokemon),
      current_pokemon: Loaded(None),
      pokemon_search: "zorua",
    )
  let content =
    client.view(model)
    |> page_scaffold(encode_all_pokemon(all_pokemon))

  wisp.response(200)
  |> wisp.set_header("Content-Type", "text/html")
  |> wisp.html_body(
    content
    |> element.to_document_string_builder(),
  )
}

/// Handler for the /pokemon route.
/// Gets all Pokemon names currently in the cache, and returns them as JSON.
fn get_all_pokemon_handler(ctx: Context) {
  let pokemon = cache.get_keys(ctx.pokemon_cache)
  let encode = json.array(_, json.string)
  pokemon
  |> encode
  |> json.to_string_builder
  |> wisp.json_response(200)
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
