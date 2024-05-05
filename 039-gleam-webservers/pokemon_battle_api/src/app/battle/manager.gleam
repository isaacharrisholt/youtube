//// The battle manager is a background process that computes and stores the results
//// of all possible battles between pairs of Pokemon at regular intervals.
////
//// It's designed as an OTP task that runs indefinitely.

import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list
import gleam/otp/task
import gleam/result
import app/battle
import app/cache.{type Cache}
import app/pokemon.{type Pokemon}

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
  let pokemon_pairs =
    cache.get_keys(pokemon_cache)
    |> list.combination_pairs

  let num_pokemon_pairs =
    list.length(pokemon_pairs)
    |> int.to_string

  io.println("Computing battles for " <> num_pokemon_pairs <> " pokemon pairs")

  list.each(pokemon_pairs, fn(pair) {
    let assert Ok(pokemon1) = cache.get(pokemon_cache, pair.0)
    let assert Ok(pokemon2) = cache.get(pokemon_cache, pair.1)

    // Battle the pokemon in both orders
    calculate_and_store_battle(pokemon1, pokemon2, battle_cache)
    calculate_and_store_battle(pokemon2, pokemon1, battle_cache)
  })

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
