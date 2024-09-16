//// This module contains the types and functions to decode and encode
//// Pokemon data from the PokeAPI. The PokeAPI returns JSON data that
//// we need to decode into our own types, and we also need to encode
//// our types into JSON to send back to the client.
////
//// Types and functions prefixed with `Api` or `api_` are used for
//// interacting with the PokeAPI. All other types are internal to
//// our application.

import gleam/dynamic.{DecodeError}
import gleam/int
import gleam/json.{int, null, nullable, object, preprocessed_array, string}
import gleam/list
import gleam/option.{type Option, None, Some}
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
fn api_stats_decoder(maybe_stats: dynamic.Dynamic) {
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
fn api_pokemon_api_move_decoder() {
  dynamic.decode1(
    ApiPokemonMove,
    dynamic.field("move", api_resource_info_decoder()),
  )
}

pub type ApiPokemonOfficialArtwork {
  ApiPokemonOfficialArtwork(front_default: String)
}

fn api_pokemon_official_artwork_decoder() {
  dynamic.decode1(
    ApiPokemonOfficialArtwork,
    dynamic.field("front_default", dynamic.string),
  )
}

pub type ApiPokemonOtherSprites {
  ApiPokemonOtherSprites(official_artwork: ApiPokemonOfficialArtwork)
}

fn api_pokemon_other_sprites_decoder() {
  dynamic.decode1(
    ApiPokemonOtherSprites,
    dynamic.field("official-artwork", api_pokemon_official_artwork_decoder()),
  )
}

pub type ApiPokemonSprites {
  ApiPokemonSprites(front_default: String, other: ApiPokemonOtherSprites)
}

fn api_pokemon_sprites_decoder() {
  dynamic.decode2(
    ApiPokemonSprites,
    dynamic.field("front_default", dynamic.string),
    dynamic.field("other", api_pokemon_other_sprites_decoder()),
  )
}

pub type ApiPokemonType {
  ApiPokemonType(type_: ApiResourceInfo, slot: Int)
}

fn api_pokemon_type_decoder() {
  dynamic.decode2(
    ApiPokemonType,
    dynamic.field("type", api_resource_info_decoder()),
    dynamic.field("slot", dynamic.int),
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
    sprites: ApiPokemonSprites,
    types: List(ApiPokemonType),
  )
}

/// Decode a Pokemon from the PokeAPI
pub fn api_pokemon_decoder() {
  dynamic.decode7(
    ApiPokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("stats", api_stats_decoder),
    dynamic.field("moves", dynamic.list(api_pokemon_api_move_decoder())),
    dynamic.field("sprites", api_pokemon_sprites_decoder()),
    dynamic.field("types", dynamic.list(api_pokemon_type_decoder())),
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
pub fn api_move_decoder() {
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

pub type PokemonType {
  Bug
  Dark
  Dragon
  Electric
  Fairy
  Fighting
  Fire
  Flying
  Ghost
  Grass
  Ground
  Ice
  Normal
  Poison
  Psychic
  Rock
  Steel
  Water
}

fn pokemon_type_from_string(string: String) -> Result(PokemonType, Nil) {
  case string {
    "bug" -> Ok(Bug)
    "dark" -> Ok(Dark)
    "dragon" -> Ok(Dragon)
    "electric" -> Ok(Electric)
    "fairy" -> Ok(Fairy)
    "fighting" -> Ok(Fighting)
    "fire" -> Ok(Fire)
    "flying" -> Ok(Flying)
    "ghost" -> Ok(Ghost)
    "grass" -> Ok(Grass)
    "ground" -> Ok(Ground)
    "ice" -> Ok(Ice)
    "normal" -> Ok(Normal)
    "poison" -> Ok(Poison)
    "psychic" -> Ok(Psychic)
    "rock" -> Ok(Rock)
    "steel" -> Ok(Steel)
    "water" -> Ok(Water)
    _ -> Error(Nil)
  }
}

pub fn pokemon_type_to_string(pokemon_type: PokemonType) -> String {
  case pokemon_type {
    Bug -> "bug"
    Dark -> "dark"
    Dragon -> "dragon"
    Electric -> "electric"
    Fairy -> "fairy"
    Fighting -> "fighting"
    Fire -> "fire"
    Flying -> "flying"
    Ghost -> "ghost"
    Grass -> "grass"
    Ground -> "ground"
    Ice -> "ice"
    Normal -> "normal"
    Poison -> "poison"
    Psychic -> "psychic"
    Rock -> "rock"
    Steel -> "steel"
    Water -> "water"
  }
}

fn pokemon_type_decoder() -> dynamic.Decoder(PokemonType) {
  fn(dyn) {
    use string <- result.try(dynamic.string(dyn))
    pokemon_type_from_string(string)
    |> result.map_error(fn(_) {
      [DecodeError(expected: "Valid pokemon type", found: string, path: [])]
    })
  }
}

pub type PokemonTypes {
  Single(PokemonType)
  Dual(PokemonType, PokemonType)
}

fn pokemon_types_decoder() -> dynamic.Decoder(PokemonTypes) {
  dynamic.decode2(
    fn(type1, type2) {
      case type2 {
        Some(type2) -> Dual(type1, type2)
        None -> Single(type1)
      }
    },
    dynamic.element(0, pokemon_type_decoder()),
    dynamic.element(1, dynamic.optional(pokemon_type_decoder())),
  )
}

/// A Pokemon with all its move details
pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    base_experience: Int,
    base_stats: Stats,
    moves: List(Move),
    sprite: String,
    artwork: String,
    types: PokemonTypes,
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
    #("sprite", string(pokemon.sprite)),
    #("artwork", string(pokemon.artwork)),
    #("types", case pokemon.types {
      Single(type_) ->
        preprocessed_array([string(type_ |> pokemon_type_to_string), null()])
      Dual(type1, type2) ->
        preprocessed_array([
          string(type1 |> pokemon_type_to_string),
          string(type2 |> pokemon_type_to_string),
        ])
    }),
  ])
}

fn stats_decoder() {
  dynamic.decode6(
    Stats,
    dynamic.field("hp", dynamic.int),
    dynamic.field("atk", dynamic.int),
    dynamic.field("def", dynamic.int),
    dynamic.field("sp_atk", dynamic.int),
    dynamic.field("sp_def", dynamic.int),
    dynamic.field("speed", dynamic.int),
  )
}

fn move_decoder() {
  dynamic.decode8(
    Move,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("accuracy", dynamic.optional(dynamic.int)),
    dynamic.field("pp", dynamic.int),
    dynamic.field("priority", dynamic.int),
    dynamic.field("power", dynamic.optional(dynamic.int)),
    dynamic.field("type", dynamic.string),
    dynamic.field("damage_class", dynamic.string),
  )
}

pub fn pokemon_decoder() {
  dynamic.decode8(
    Pokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("base_stats", stats_decoder()),
    dynamic.field("moves", dynamic.list(move_decoder())),
    dynamic.field("sprite", dynamic.string),
    dynamic.field("artwork", dynamic.string),
    dynamic.field("types", pokemon_types_decoder()),
  )
}

pub fn api_pokemon_to_pokemon(
  pokemon: ApiPokemon,
  moves: List(Move),
) -> Result(Pokemon, Nil) {
  let type_result = case
    pokemon.types
    |> list.sort(fn(t1, t2) { int.compare(t1.slot, t2.slot) })
  {
    [ApiPokemonType(type_, 1)] -> {
      use type_name <- result.try(type_.name |> pokemon_type_from_string)
      Ok(Single(type_name))
    }
    [ApiPokemonType(type_, 1), ApiPokemonType(type2, 2)] -> {
      use type1_name <- result.try(type_.name |> pokemon_type_from_string)
      use type2_name <- result.try(type2.name |> pokemon_type_from_string)
      Ok(Dual(type1_name, type2_name))
    }
    _ -> Error(Nil)
  }

  use types <- result.try(type_result)

  Ok(Pokemon(
    id: pokemon.id,
    name: pokemon.name,
    base_experience: pokemon.base_experience,
    base_stats: pokemon.base_stats,
    moves: moves,
    sprite: pokemon.sprites.front_default,
    artwork: pokemon.sprites.other.official_artwork.front_default,
    types:,
  ))
}

pub fn type_to_background(pokemon_type: PokemonTypes) -> String {
  let type_ = case pokemon_type {
    Single(type_) -> type_
    Dual(type1, _) -> type1
  }

  case type_ {
    Bug -> "bg-bug"
    Dark -> "bg-dark"
    Dragon -> "bg-dragon"
    Electric -> "bg-electric"
    Fairy -> "bg-fairy"
    Fighting -> "bg-fighting"
    Fire -> "bg-fire"
    Flying -> "bg-flying"
    Ghost -> "bg-ghost"
    Grass -> "bg-grass"
    Ground -> "bg-ground"
    Ice -> "bg-ice"
    Normal -> "bg-normal"
    Poison -> "bg-poison"
    Psychic -> "bg-psychic"
    Rock -> "bg-rock"
    Steel -> "bg-steel"
    Water -> "bg-water"
  }
}

pub fn type_to_ring_colour(pokemon_type: PokemonTypes) -> String {
  let type_ = case pokemon_type {
    Single(type_) -> type_
    Dual(type1, _) -> type1
  }

  case type_ {
    Bug -> "focus-visible:ring-bug"
    Dark -> "focus-visible:ring-dark"
    Dragon -> "focus-visible:ring-dragon"
    Electric -> "focus-visible:ring-electric"
    Fairy -> "focus-visible:ring-fairy"
    Fighting -> "focus-visible:ring-fighting"
    Fire -> "focus-visible:ring-fire"
    Flying -> "focus-visible:ring-flying"
    Ghost -> "focus-visible:ring-ghost"
    Grass -> "focus-visible:ring-grass"
    Ground -> "focus-visible:ring-ground"
    Ice -> "focus-visible:ring-ice"
    Normal -> "focus-visible:ring-normal"
    Poison -> "focus-visible:ring-poison"
    Psychic -> "focus-visible:ring-psychic"
    Rock -> "focus-visible:ring-rock"
    Steel -> "focus-visible:ring-steel"
    Water -> "focus-visible:ring-water"
  }
}
