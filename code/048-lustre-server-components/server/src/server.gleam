import gleam/erlang/process
import mist
import server/battle/manager
import server/cache
import server/context.{Context}
import server/router
import wisp

pub fn main() {
  // Set up the Wisp logger for Erlang
  wisp.configure_logger()

  // Create the caches and assign them to the context
  let assert Ok(pokemon_cache) = cache.new()
  let assert Ok(move_cache) = cache.new()
  let assert Ok(battle_cache) = cache.new()
  let assert Ok(pokemon_lists) = cache.new()
  let context = Context(pokemon_cache, move_cache, battle_cache, pokemon_lists)

  // Create a handler using the function capture syntax.
  // This is similar to a partial application in other languages.
  let handler = router.handle_request(_, context)

  // Start battle manager in the background
  manager.start(pokemon_cache, battle_cache)

  // Start the Mist server
  let assert Ok(_) =
    // wisp.mist_handler(handler, secret_key_base)
    handler
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  // Sleep forever to allow the server to run
  process.sleep_forever()
}
