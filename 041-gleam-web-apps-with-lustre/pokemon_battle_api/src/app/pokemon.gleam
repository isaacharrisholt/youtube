//// This module contains the types and functions to decode and encode
//// Pokemon data from the PokeAPI. The PokeAPI returns JSON data that
//// we need to decode into our own types, and we also need to encode
//// our types into JSON to send back to the client.
////
//// Types and functions prefixed with `Api` or `api_` are used for
//// interacting with the PokeAPI. All other types are internal to
//// our application.

import gleam/dynamic
import gleam/json.{int, nullable, object, preprocessed_array, string}
import gleam/list
import gleam/option.{type Option}
import gleam/result

/// Info about a resource
pub type ApiResourceInfo {
  ApiResourceInfo(name: String, url: String)
}

/// A decoder for an ApiResourceInfo object
fn api_resource_info_decoder() {
  dynamic.decode2(
    ApiResourceInfo,
    dynamic.field("name", dynamic.string),
    dynamic.field("url", dynamic.string),
  )
}

/// Decode a dynamic resource info and extract its name
fn api_resource_info_name_decoder(maybe_api_resource_info: dynamic.Dynamic) {
  let decoder = api_resource_info_decoder()
  case decoder(maybe_api_resource_info) {
    Error(err) -> Error(err)
    Ok(api_resource_info) -> Ok(api_resource_info.name)
  }
}

/// A single stat as returned by the PokeAPI
pub type ApiStat {
  ApiStat(base_stat: Int, effort: Int, name: String)
}

/// A decoder for an ApiStat object.
///
/// Extracts the stat.name field from the API response.
fn api_stat_decoder() {
  dynamic.decode3(
    ApiStat,
    dynamic.field("base_stat", dynamic.int),
    dynamic.field("effort", dynamic.int),
    dynamic.field("stat", api_resource_info_name_decoder),
  )
}

/// Search for a base stat in a list of stats
fn get_base_stat(stats: List(ApiStat), stat: String) -> Result(Int, Nil) {
  case list.find(stats, fn(pokemon_stat) { pokemon_stat.name == stat }) {
    Ok(pokemon_stat) -> Ok(pokemon_stat.base_stat)
    Error(_) -> Error(Nil)
  }
}

/// A Pokemon's stats
pub type Stats {
  Stats(hp: Int, atk: Int, def: Int, sp_atk: Int, sp_def: Int, speed: Int)
}

/// Convert a list of API stats to a Stats object
fn api_stats_to_stats(api_stats: List(ApiStat)) -> Result(Stats, Nil) {
  use hp <- result.try(get_base_stat(api_stats, "hp"))
  use atk <- result.try(get_base_stat(api_stats, "attack"))
  use def <- result.try(get_base_stat(api_stats, "defense"))
  use sp_atk <- result.try(get_base_stat(api_stats, "special-attack"))
  use sp_def <- result.try(get_base_stat(api_stats, "special-defense"))
  use speed <- result.try(get_base_stat(api_stats, "speed"))

  Ok(Stats(hp, atk, def, sp_atk, sp_def, speed))
}

/// Decodes a Stats object from the PokeAPI representation:
/// ```json
/// [
///   {
///     "base_stat": 45,
///     "effort": 0,
///     "stat": {
///       "name": "hp",
///       "url": "https://pokeapi.co/api/v2/stat/1/"
///     }
///   },
///   ...
/// ]
/// ```
fn stats_decoder(maybe_stats: dynamic.Dynamic) {
  let decoder = dynamic.list(api_stat_decoder())
  case decoder(maybe_stats) {
    Error(err) -> Error(err)
    Ok(stats) -> {
      case api_stats_to_stats(stats) {
        Ok(stats) -> Ok(stats)
        // Not filling this out for now, but we could provide a more detailed error message
        Error(_) -> Error([dynamic.DecodeError("", "", [""])])
      }
    }
  }
}

/// Encode a Stats object into a JSON object
fn encode_stats(stats: Stats) {
  object([
    #("hp", int(stats.hp)),
    #("atk", int(stats.atk)),
    #("def", int(stats.def)),
    #("sp_atk", int(stats.sp_atk)),
    #("sp_def", int(stats.sp_def)),
    #("speed", int(stats.speed)),
  ])
}

/// Information about a move returned by the PokeAPI
/// as part of the Pokemon resource
pub type ApiPokemonMove {
  ApiPokemonMove(move: ApiResourceInfo)
}

/// Decode a Pokemon move from the PokeAPI
fn api_pokemon_move_decoder() {
  dynamic.decode1(
    ApiPokemonMove,
    dynamic.field("move", api_resource_info_decoder()),
  )
}

/// A Pokemon as returned by the PokeAPI
pub type ApiPokemon {
  ApiPokemon(
    id: Int,
    name: String,
    base_experience: Int,
    base_stats: Stats,
    moves: List(ApiPokemonMove),
  )
}

/// Decode a Pokemon from the PokeAPI
pub fn api_pokemon_decoder() {
  dynamic.decode5(
    ApiPokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("stats", stats_decoder),
    dynamic.field("moves", dynamic.list(api_pokemon_move_decoder())),
  )
}

/// A Pokemon's move
pub type Move {
  Move(
    id: Int,
    name: String,
    accuracy: Option(Int),
    pp: Int,
    priority: Int,
    power: Option(Int),
    type_: String,
    damage_class: String,
  )
}

/// Decode a Move from the PokeAPI.
///
/// Extracts type.name and damage_class.name from the API response.
pub fn move_decoder() {
  dynamic.decode8(
    Move,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("accuracy", dynamic.optional(dynamic.int)),
    dynamic.field("pp", dynamic.int),
    dynamic.field("priority", dynamic.int),
    dynamic.field("power", dynamic.optional(dynamic.int)),
    dynamic.field("type", api_resource_info_name_decoder),
    dynamic.field("damage_class", api_resource_info_name_decoder),
  )
}

/// Encode a Move object into a JSON object
fn encode_move(move: Move) {
  object([
    #("id", int(move.id)),
    #("name", string(move.name)),
    #("accuracy", nullable(move.accuracy, int)),
    #("pp", int(move.pp)),
    #("priority", int(move.priority)),
    #("power", nullable(move.power, int)),
    #("type", string(move.type_)),
    #("damage_class", string(move.damage_class)),
  ])
}

/// A Pokemon with all its move details
pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    base_experience: Int,
    base_stats: Stats,
    moves: List(Move),
  )
}

/// Encode a Pokemon object into a JSON object
pub fn encode_pokemon(pokemon: Pokemon) {
  object([
    #("id", int(pokemon.id)),
    #("name", string(pokemon.name)),
    #("base_experience", int(pokemon.base_experience)),
    #("base_stats", encode_stats(pokemon.base_stats)),
    #("moves", preprocessed_array(list.map(pokemon.moves, encode_move))),
  ])
}
