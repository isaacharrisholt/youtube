import gleam/otp/task
import gleam/erlang/process
import gleam/list
import gleam/int
import gleam/result
import gleam/io
import app/cache.{type Cache}
import app/pokemon.{type PokemonWithMoves}
import app/battle

pub fn start(
  pokemon_cache: Cache(PokemonWithMoves),
  battle_cache: Cache(PokemonWithMoves),
) {
  task.async(fn() { compute_all_battles(pokemon_cache, battle_cache) })
}

fn compute_all_battles(
  pokemon_cache: Cache(PokemonWithMoves),
  battle_cache: Cache(PokemonWithMoves),
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
    // We'll ignore any failures
    calculate_and_store_battle(pokemon1, pokemon2, battle_cache)
    calculate_and_store_battle(pokemon2, pokemon1, battle_cache)
  })

  // Recursively call this function every 10 seconds
  process.sleep(10_000)
  compute_all_battles(pokemon_cache, battle_cache)
}

fn calculate_and_store_battle(
  pokemon1: PokemonWithMoves,
  pokemon2: PokemonWithMoves,
  battle_cache: Cache(PokemonWithMoves),
) {
  let assert Ok(r) =
    result.try(battle.battle(pokemon1, pokemon2), fn(winner) {
      cache.get_composite_key([pokemon1.pokemon.name, pokemon2.pokemon.name])
      |> cache.set(battle_cache, _, winner)
      Ok(Nil)
    })
  r
}
