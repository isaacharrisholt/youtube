import gleam/float
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import app/pokemon.{type Move, type PokemonWithMoves}

const battle_level = 100

type PokemonProfile {
  PokemonProfile(
    name: String,
    hp: Int,
    attack: Int,
    defense: Int,
    speed: Int,
    most_powerful_move: Move,
  )
}

pub fn battle(
  pokemon1: PokemonWithMoves,
  pokemon2: PokemonWithMoves,
) -> Result(PokemonWithMoves, Nil) {
  use pokemon1_profile <- result.try(get_pokemon_profile(pokemon1))
  use pokemon2_profile <- result.try(get_pokemon_profile(pokemon2))

  io.println(
    "Battle between "
    <> pokemon1.pokemon.name
    <> " and "
    <> pokemon2.pokemon.name,
  )

  battle_loop(pokemon1_profile, pokemon2_profile)
  |> result.map(fn(winner) {
    case winner.name == pokemon1.pokemon.name {
      True -> pokemon1
      False -> pokemon2
    }
  })
}

fn battle_loop(
  pokemon1: PokemonProfile,
  pokemon2: PokemonProfile,
) -> Result(PokemonProfile, Nil) {
  io.println(pokemon1.name <> " HP: " <> int.to_string(pokemon1.hp))
  io.println(pokemon2.name <> " HP: " <> int.to_string(pokemon2.hp))
  case pokemon1.hp, pokemon2.hp {
    // If either pokemon has fainted, the other wins
    x, _ if x <= 0 -> Ok(pokemon2)
    _, x if x <= 0 -> Ok(pokemon1)
    _, _ -> {
      let pokemon1_damage = move_damage(pokemon1, pokemon2)
      let pokemon2_damage = move_damage(pokemon2, pokemon1)

      io.println(
        pokemon1.name
        <> " attacks "
        <> pokemon2.name
        <> " with "
        <> pokemon1.most_powerful_move.name
        <> " for "
        <> int.to_string(pokemon1_damage)
        <> " damage",
      )

      let new_pokemon2_hp = pokemon2.hp - pokemon1_damage

      case new_pokemon2_hp {
        // If pokemon 2 has fainted, pokemon 1 wins
        x if x <= 0 -> Ok(pokemon1)
        _ -> {
          io.println(
            pokemon2.name
            <> " attacks "
            <> pokemon1.name
            <> " with "
            <> pokemon2.most_powerful_move.name
            <> " for "
            <> int.to_string(pokemon2_damage)
            <> " damage",
          )

          let new_pokemon1_hp = pokemon1.hp - pokemon2_damage

          let new_pokemon1 =
            PokemonProfile(
              pokemon1.name,
              new_pokemon1_hp,
              pokemon1.attack,
              pokemon1.defense,
              pokemon1.speed,
              pokemon1.most_powerful_move,
            )

          let new_pokemon2 =
            PokemonProfile(
              pokemon2.name,
              new_pokemon2_hp,
              pokemon2.attack,
              pokemon2.defense,
              pokemon2.speed,
              pokemon2.most_powerful_move,
            )

          battle_loop(new_pokemon1, new_pokemon2)
        }
      }
    }
  }
}

/// Calculates the damage dealt by a move.
/// Note, this is a very simple calculation and does not
/// take into account many factors such as type effectiveness,
/// critical hits, or status effects.
/// It also only uses attack and defense, not special attack
/// and special defense.
fn move_damage(attacker: PokemonProfile, defender: PokemonProfile) -> Int {
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

fn get_pokemon_profile(pokemon: PokemonWithMoves) -> Result(PokemonProfile, Nil) {
  use base_hp <- result.try(get_base_stat(pokemon, "hp"))
  use base_attack <- result.try(get_base_stat(pokemon, "attack"))
  use base_defense <- result.try(get_base_stat(pokemon, "defense"))
  use base_speed <- result.try(get_base_stat(pokemon, "speed"))

  let hp = calculate_hp(base_hp, battle_level)
  let attack = calculate_stat(base_attack, battle_level)
  let defense = calculate_stat(base_defense, battle_level)
  let speed = calculate_stat(base_speed, battle_level)

  case get_most_powerful_move(pokemon.moves) {
    Ok(most_powerful_move) ->
      Ok(PokemonProfile(
        pokemon.pokemon.name,
        hp,
        attack,
        defense,
        speed,
        most_powerful_move,
      ))
    Error(_) -> Error(Nil)
  }
}

fn get_base_stat(pokemon: PokemonWithMoves, stat: String) -> Result(Int, Nil) {
  case
    list.find(pokemon.pokemon.stats, fn(pokemon_stat) {
      pokemon_stat.stat.name == stat
    })
  {
    Ok(pokemon_stat) -> Ok(pokemon_stat.base_stat)
    Error(_) -> Error(Nil)
  }
}

fn calculate_stat(base_stat: Int, level: Int) -> Int {
  let base_stat_float = int.to_float(base_stat)
  let level_float = int.to_float(level)

  let intermediate =
    { 0.01 *. 2.0 *. base_stat_float *. level_float }
    |> float.floor
    |> float.round

  intermediate + 5
}

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
/// using the 'expected power' (base power * accuracy)
fn get_most_powerful_move(moves: List(Move)) {
  list.fold(moves, Error(Nil), fn(curr, next) {
    case curr, next.power {
      // No current, but there is a next
      // which has a power. Return the next
      Error(_), Some(_) -> Ok(next)
      // No current, next has no power.
      // Return Error(Nil)
      Error(_), None -> Error(Nil)
      // Current exists (and therefore has a power),
      // but next doesn't
      Ok(curr), None -> Ok(curr)
      Ok(curr), Some(next_power) -> {
        // We know curr MUST have a power
        let assert Some(curr_power) = curr.power
        let curr_accuracy = option.unwrap(curr.accuracy, 100)
        let next_accuracy = option.unwrap(next.accuracy, 100)
        let curr_expected_power = curr_power * curr_accuracy
        let next_expected_power = next_power * next_accuracy

        case curr_expected_power > next_expected_power {
          True -> Ok(curr)
          False -> Ok(next)
        }
      }
    }
  })
}
