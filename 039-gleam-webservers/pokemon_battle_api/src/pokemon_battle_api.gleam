import gleam/erlang/process
import mist
import wisp
import app/battle/manager
import app/cache
import app/context.{Context}
import app/router

pub fn main() {
  wisp.configure_logger()
  let secret_key_base = wisp.random_string(64)

  let assert Ok(pokemon_cache) = cache.new()
  let assert Ok(move_cache) = cache.new()
  let assert Ok(battle_cache) = cache.new()

  let context = Context(pokemon_cache, move_cache, battle_cache)
  let handler = router.handle_request(_, context)

  // Start battle manager
  manager.start(pokemon_cache, battle_cache)

  let assert Ok(_) =
    wisp.mist_handler(handler, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  process.sleep_forever()
}
