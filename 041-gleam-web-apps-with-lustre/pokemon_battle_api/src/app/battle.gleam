//// The battle module contains functions for simulating battles between Pokemon.
//// Many features of battles are not implemented, such as status effects, critical hits,
//// and type effectiveness. This is a simple battle simulation that only uses the
//// most powerful move of each Pokemon (by effective power) and does not take into account
//// many factors that would be present in a real Pokemon battle.
////
//// Only attack and defense stats are considered. Speed and priority are not implemented.
//// The first Pokemon to attack each turn will always be the first Pokemon in the battle.

import gleam/float
import gleam/int
import gleam/list
import gleam/option.{Some}
import gleam/result
import wisp
import app/pokemon.{type Move, type Pokemon}

/// The level of the Pokemon in the battle
const battle_level = 100

/// Simulate a battle between two Pokemon.
/// The loser is the Pokemon that faints first (HP <= 0).
/// This function can fail if either Pokemon only has non-attacking moves.
pub fn battle(pokemon1: Pokemon, pokemon2: Pokemon) -> Result(Pokemon, Nil) {
  use battle_pokemon1 <- result.try(get_battle_pokemon(pokemon1))
  use battle_pokemon2 <- result.try(get_battle_pokemon(pokemon2))

  wisp.log_debug("Battle between " <> pokemon1.name <> " and " <> pokemon2.name)

  battle_loop(battle_pokemon1, battle_pokemon2)
  |> result.map(fn(winner) {
    case winner.name == pokemon1.name {
      True -> pokemon1
      False -> pokemon2
    }
  })
}

/// Represents a Pokemon in battle
type BattlePokemon {
  BattlePokemon(
    name: String,
    hp: Int,
    attack: Int,
    defense: Int,
    speed: Int,
    most_powerful_move: Move,
  )
}

/// Convert a Pokemon to a BattlePokemon. 
/// Fails if the Pokemon has not attacking moves (all moves have no power).
fn get_battle_pokemon(pokemon: Pokemon) -> Result(BattlePokemon, Nil) {
  let hp = calculate_hp(pokemon.base_stats.hp, battle_level)
  let attack = calculate_stat(pokemon.base_stats.atk, battle_level)
  let defense = calculate_stat(pokemon.base_stats.def, battle_level)
  let speed = calculate_stat(pokemon.base_stats.speed, battle_level)

  case get_most_powerful_move(pokemon.moves) {
    Ok(most_powerful_move) ->
      Ok(BattlePokemon(
        pokemon.name,
        hp,
        attack,
        defense,
        speed,
        most_powerful_move,
      ))
    Error(_) -> Error(Nil)
  }
}

/// The recursive battle loop.
/// Each Pokemon attacks the other with their most powerful move.
/// The first Pokemon to faint loses.
/// If both Pokemon faint on the same turn, the first Pokemon wins,
/// as in a real battle, the second Pokemon would not get to attack.
fn battle_loop(
  pokemon1: BattlePokemon,
  pokemon2: BattlePokemon,
) -> Result(BattlePokemon, Nil) {
  wisp.log_debug(pokemon1.name <> " HP: " <> int.to_string(pokemon1.hp))
  wisp.log_debug(pokemon2.name <> " HP: " <> int.to_string(pokemon2.hp))
  case pokemon1.hp, pokemon2.hp {
    // If either pokemon has fainted, the other wins
    x, _ if x <= 0 -> Ok(pokemon2)
    _, x if x <= 0 -> Ok(pokemon1)
    _, _ -> {
      let new_pokemon2 = do_attack(attacker: pokemon1, defender: pokemon2)
      let new_pokemon1 = do_attack(attacker: pokemon2, defender: pokemon1)

      battle_loop(new_pokemon1, new_pokemon2)
    }
  }
}

/// Simulate an attack between two Pokemon.
/// Returns the defender with updated HP.
fn do_attack(
  attacker attacker: BattlePokemon,
  defender defender: BattlePokemon,
) -> BattlePokemon {
  let damage = move_damage(attacker, defender)
  let new_hp = defender.hp - damage

  wisp.log_debug(
    attacker.name
    <> " attacks "
    <> defender.name
    <> " with "
    <> attacker.most_powerful_move.name
    <> " for "
    <> int.to_string(damage)
    <> " damage",
  )

  BattlePokemon(
    defender.name,
    new_hp,
    defender.attack,
    defender.defense,
    defender.speed,
    defender.most_powerful_move,
  )
}

/// Calculates the damage dealt by a move.
///
/// Note, this is a very simple calculation and does not
/// take into account many factors such as type effectiveness,
/// critical hits, or status effects.
///
/// It also only uses attack and defense, not special attack
/// and special defense.
fn move_damage(attacker: BattlePokemon, defender: BattlePokemon) -> Int {
  let attack = attacker.attack
  let defense = defender.defense
  let move = attacker.most_powerful_move

  let power = option.unwrap(move.power, 0)
  let accuracy = option.unwrap(move.accuracy, 100)
  let miss_chance = int.random(100)

  case miss_chance > accuracy {
    // Miss
    True -> 0
    False -> {
      // Calculate damage using the damage formula
      let battle_level = int.to_float(battle_level)
      let power = int.to_float(power)
      let attack = int.to_float(attack)
      let defense = int.to_float(defense)

      let intermediate =
        {
          { { 2.0 *. battle_level /. 5.0 } +. 2.0 }
          *. power
          *. attack
          /. defense
        }
        /. 50.0
        |> float.floor
        |> float.round

      intermediate + 2
    }
  }
}

/// Calculate a stat for a Pokemon at a given level.
/// This does not apply to the HP stat.
fn calculate_stat(base_stat: Int, level: Int) -> Int {
  let base_stat_float = int.to_float(base_stat)
  let level_float = int.to_float(level)

  let intermediate =
    { 0.01 *. 2.0 *. base_stat_float *. level_float }
    |> float.floor
    |> float.round

  intermediate + 5
}

/// Calculate the HP stat for a Pokemon at a given level.
fn calculate_hp(base_stat: Int, level: Int) -> Int {
  let base_stat_float = int.to_float(base_stat)
  let level_float = int.to_float(level)

  let intermediate =
    { 0.01 *. 2.0 *. base_stat_float *. level_float }
    |> float.floor
    |> float.round

  intermediate + level + 10
}

/// Calculate the most powerful move from a list
/// using the 'expected power' (base power * accuracy).
/// Filters out moves with no power, and will fail
/// if all moves have no power.
fn get_most_powerful_move(moves: List(Move)) -> Result(Move, Nil) {
  moves
  |> list.filter(fn(move) { option.is_some(move.power) })
  |> list.reduce(fn(curr, next) {
    // We know curr and next MUST have a power
    let assert Some(curr_power) = curr.power
    let assert Some(next_power) = next.power
    let curr_accuracy = option.unwrap(curr.accuracy, 100)
    let next_accuracy = option.unwrap(next.accuracy, 100)
    let curr_expected_power = curr_power * curr_accuracy
    let next_expected_power = next_power * next_accuracy

    case curr_expected_power > next_expected_power {
      True -> curr
      False -> next
    }
  })
}
