import gleam/dynamic
import gleam/option.{type Option}

/// A Pokemon's stats
pub type Stats {
  Stats(hp: Int, atk: Int, def: Int, sp_atk: Int, sp_def: Int, speed: Int)
}

fn stats_decoder() -> fn(dynamic.Dynamic) ->
  Result(Stats, List(dynamic.DecodeError)) {
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

fn move_decoder() -> fn(dynamic.Dynamic) ->
  Result(Move, List(dynamic.DecodeError)) {
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

pub fn pokemon_decoder() -> fn(dynamic.Dynamic) ->
  Result(Pokemon, List(dynamic.DecodeError)) {
  dynamic.decode5(
    Pokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("base_stats", stats_decoder()),
    dynamic.field("moves", dynamic.list(move_decoder())),
  )
}
