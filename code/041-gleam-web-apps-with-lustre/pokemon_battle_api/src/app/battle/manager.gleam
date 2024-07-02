//// The battle manager is a background process that computes and stores the results
//// of all possible battles between pairs of Pokemon at regular intervals.
////
//// It's designed as an OTP task that runs indefinitely.

import app/battle
import app/cache.{type Cache}
import app/pokemon.{type Pokemon}
import birl
import birl/duration
import gleam/erlang/process
import gleam/float
import gleam/int
import gleam/list
import gleam/otp/task
import gleam/result
import wisp

const sleep_time = 10_000

/// Start the battle manager. Creates a new task that will run indefinitely.
pub fn start(pokemon_cache: Cache(Pokemon), battle_cache: Cache(Pokemon)) {
  task.async(fn() { compute_all_battles(pokemon_cache, battle_cache) })
}

/// Compute all possible battles between pairs of Pokemon at regular intervals.
/// Tail calls are optimised automatically in Gleam, so we don't need to worry
/// about stack overflows.
/// For more information: https://tour.gleam.run/flow-control/tail-calls/
fn compute_all_battles(
  pokemon_cache: Cache(Pokemon),
  battle_cache: Cache(Pokemon),
) {
  let all_pokemon = cache.get_keys(pokemon_cache)

  let pokemon_pairs =
    all_pokemon
    |> list.combination_pairs

  let num_pokemon =
    list.length(all_pokemon)
    |> int.to_string

  let num_pokemon_pairs =
    list.length(pokemon_pairs)
    |> int.to_string

  case num_pokemon_pairs {
    "0" -> wisp.log_info("No pokemon to battle")
    _ ->
      wisp.log_info(
        "Computing battles for "
        <> num_pokemon_pairs
        <> " Pokemon pairs ("
        <> num_pokemon
        <> " Pokemon)",
      )
  }

  let start = birl.utc_now()

  list.each(pokemon_pairs, fn(pair) {
    let assert Ok(pokemon1) = cache.get(pokemon_cache, pair.0)
    let assert Ok(pokemon2) = cache.get(pokemon_cache, pair.1)

    // Battle the pokemon in both orders
    calculate_and_store_battle(pokemon1, pokemon2, battle_cache)
    calculate_and_store_battle(pokemon2, pokemon1, battle_cache)
  })

  case num_pokemon_pairs {
    "0" -> Nil
    _ -> {
      let end = birl.utc_now()
      let duration.Duration(microseconds) = birl.difference(end, start)
      let seconds = int.to_float(microseconds) /. 1_000_000.0
      wisp.log_info("Computed battles in " <> float.to_string(seconds) <> "s")
    }
  }

  // Recursively call this function at an interval
  process.sleep(sleep_time)
  compute_all_battles(pokemon_cache, battle_cache)
}

/// Calculate the result of a battle between two Pokemon and store it in the cache.
/// Failures are ignored.
fn calculate_and_store_battle(
  pokemon1: Pokemon,
  pokemon2: Pokemon,
  battle_cache: Cache(Pokemon),
) {
  battle.battle(pokemon1, pokemon2)
  |> result.try(fn(winner) {
    cache.create_composite_key([pokemon1.name, pokemon2.name])
    |> cache.set(battle_cache, _, winner)
    Ok(Nil)
  })
  |> result.unwrap(Nil)
}
