//// Routes defined in our application.
////
//// We use a single handler for all requests, and route the request
//// based on the path segments. This allows us to keep all of our
//// application logic in one place, and to easily add new routes.

import client.{Model}
import client/api.{Loaded}
import gleam/bytes_builder
import gleam/erlang
import gleam/erlang/process
import gleam/http.{Options}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import gleam/json
import gleam/list
import gleam/option.{None}
import gleam/result
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html.{html}
import lustre/server_component
import mist.{type Connection, type ResponseData}
import server/battle
import server/cache
import server/components/pokemon_list
import server/context.{type Context}
import server/pokeapi.{get_moves_for_pokemon, get_pokemon}
import shared/components/pokemon_list as shared_pokemon_list
import shared/pokemon.{api_pokemon_to_pokemon, encode_pokemon}

fn cors_middleware(
  req: Request(Connection),
  fun: fn() -> Response(ResponseData),
) -> Response(ResponseData) {
  case req.method {
    Options -> {
      response.new(200)
      |> response.set_header("Access-Control-Allow-Origin", "*")
      |> response.set_header(
        "Access-Control-Allow-Methods",
        "GET, POST, OPTIONS",
      )
      |> response.set_header("Access-Control-Allow-Headers", "Content-Type")
      |> response.set_body(bytes_builder.from_string("") |> mist.Bytes)
    }
    _ -> {
      fun()
      |> response.set_header("Access-Control-Allow-Origin", "*")
      |> response.set_header(
        "Access-Control-Allow-Methods",
        "GET, POST, OPTIONS",
      )
      |> response.set_header("Access-Control-Allow-Headers", "Content-Type")
    }
  }
}

fn file_middleware(
  req: Request(Connection),
  filename: String,
  content_type: String,
  fun: fn() -> Response(ResponseData),
) -> Response(ResponseData) {
  let assert Ok(priv) = erlang.priv_directory("server")
  let path = priv <> "/" <> filename

  case request.path_segments(req) {
    ["static", f] if f == filename -> {
      mist.send_file(path, offset: 0, limit: None)
      |> result.map(fn(file) {
        response.new(200)
        |> response.set_header("Content-Type", content_type)
        |> response.set_body(file)
      })
      |> result.lazy_unwrap(fn() {
        response.new(404)
        |> response.set_body(
          bytes_builder.from_string("Not Found") |> mist.Bytes,
        )
      })
    }
    _ -> fun()
  }
}

/// Route the request to the appropriate handler based on the path segments.
pub fn handle_request(
  req: Request(Connection),
  ctx: Context,
) -> Response(ResponseData) {
  use <- cors_middleware(req)
  use <- file_middleware(req, "client.mjs", "application/javascript")
  use <- file_middleware(req, "client.css", "text/css")

  case request.path_segments(req) {
    // Home
    [] -> home(ctx)
    // Websocket
    ["pokemon-list"] ->
      mist.websocket(
        request: req,
        on_init: pokemon_list.socket_init(
          _,
          ctx.pokemon_cache,
          ctx.pokemon_lists,
        ),
        handler: pokemon_list.socket_update,
        on_close: pokemon_list.socket_close(_, ctx.pokemon_lists),
      )
    // /pokemon
    ["pokemon"] -> get_all_pokemon_handler(ctx)
    // /pokemon/:name
    ["pokemon", name] -> get_pokemon_handler(ctx, name)
    // /battle/:name1/:name2
    ["battle", name1, name2] -> get_battle_handler(ctx, name1, name2)
    // Any non-matching routes
    _ ->
      response.new(404)
      |> response.set_body(bytes_builder.from_string("Not Found") |> mist.Bytes)
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
      html.link([
        attribute.rel("preconnect"),
        attribute.href("https://fonts.bunny.net"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("https://fonts.bunny.net/css?family=press-start-2p:400"),
      ]),
      server_component.script(),
    ]),
    html.body([], [html.div([attribute.id("app")], [content])]),
  ])
}

fn home(ctx: Context) -> Response(ResponseData) {
  let all_pokemon = cache.get_values(ctx.pokemon_cache)
  let model =
    Model(
      current_pokemon: Loaded(None),
      pokemon_search: "",
      all_pokemon: all_pokemon,
    )
  let pokemon_json = json.array(all_pokemon, encode_pokemon) |> json.to_string
  let content =
    client.view(model)
    |> page_scaffold(pokemon_json)

  response.new(200)
  |> response.set_header("Content-Type", "text/html")
  |> response.set_body(
    content
    |> element.to_string_builder
    |> bytes_builder.from_string_builder
    |> mist.Bytes,
  )
}

/// Handler for the /pokemon route.
/// Gets all Pokemon names currently in the cache, and returns them as JSON.
fn get_all_pokemon_handler(ctx: Context) {
  let pokemon = cache.get_keys(ctx.pokemon_cache)
  let encode = json.array(_, json.string)

  response.new(200)
  |> response.set_header("Content-Type", "application/json")
  |> response.set_body(
    pokemon
    |> encode
    |> json.to_string_builder
    |> bytes_builder.from_string_builder
    |> mist.Bytes,
  )
}

/// Fetch a Pokemon from the PokeAPI.
///
/// Will also fetch the moves for the Pokemon, and cache the result.
fn fetch_pokemon(ctx: Context, name: String) {
  io.debug("Fetching Pokemon: " <> name)
  case cache.get(ctx.pokemon_cache, name) {
    Ok(pokemon) -> Ok(pokemon)
    Error(_) -> {
      use pokemon <- result.try(get_pokemon(name))
      use moves <- result.try(get_moves_for_pokemon(pokemon, ctx.move_cache))
      use pokemon_with_moves <- result.try(
        api_pokemon_to_pokemon(pokemon, moves)
        |> result.replace_error("Failed to convert API Pokemon to Pokemon"),
      )
      cache.set(ctx.pokemon_cache, pokemon.name, pokemon_with_moves)
      io.debug("Sending pokemon to Pokemon lists")

      let pokemon_lists = cache.get_values(ctx.pokemon_lists)
      pokemon_lists
      |> list.each(fn(pokemon_list) {
        process.send(
          pokemon_list,
          lustre.dispatch(shared_pokemon_list.ServerAddedPokemon(
            pokemon_with_moves,
          )),
        )
      })
      Ok(pokemon_with_moves)
    }
  }
}

/// Handler for the /pokemon/:name route.
/// Fetches the requested Pokemon, encodes it as JSON, and returns it.
fn get_pokemon_handler(ctx: Context, name: String) -> Response(ResponseData) {
  case fetch_pokemon(ctx, name) {
    Ok(pokemon) -> {
      response.new(200)
      |> response.set_header("Content-Type", "application/json")
      |> response.set_body(
        encode_pokemon(pokemon)
        |> json.to_string_builder
        |> bytes_builder.from_string_builder
        |> mist.Bytes,
      )
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
          cache.create_composite_key([pokemon1.name, pokemon2.name])
          |> cache.set(ctx.battle_cache, _, winner)
          Ok(winner)
        }
        Error(_) -> Error("Failed to battle " <> name1 <> " vs " <> name2)
      }
    }
  }
  case result {
    Ok(pokemon) -> {
      response.new(200)
      |> response.set_header("Content-Type", "application/json")
      |> response.set_body(
        json.object([#("winner", json.string(pokemon.name))])
        |> json.to_string_builder
        |> bytes_builder.from_string_builder
        |> mist.Bytes,
      )
    }
    Error(msg) -> error_response(msg)
  }
}

/// Create an error response from a message.
fn error_response(msg: String) -> Response(ResponseData) {
  response.new(500)
  |> response.set_header("Content-Type", "application/json")
  |> response.set_body(
    json.object([#("error", json.string(msg))])
    |> json.to_string_builder
    |> bytes_builder.from_string_builder
    |> mist.Bytes,
  )
}
