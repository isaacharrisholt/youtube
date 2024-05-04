import gleam/dynamic
import gleam/option.{type Option}

/// Info about a resource
pub type ResourceInfo {
  ResourceInfo(name: String, url: String)
}

fn resource_info_decoder() {
  dynamic.decode2(
    ResourceInfo,
    dynamic.field("name", dynamic.string),
    dynamic.field("url", dynamic.string),
  )
}

/// A Pokemon's base stat
pub type Stat {
  Stat(base_stat: Int, effort: Int, stat: ResourceInfo)
}

fn stat_decoder() {
  dynamic.decode3(
    Stat,
    dynamic.field("base_stat", dynamic.int),
    dynamic.field("effort", dynamic.int),
    dynamic.field("stat", resource_info_decoder()),
  )
}

/// A move that a Pokemon can learn
pub type LearnableMove {
  LearnableMove(move: ResourceInfo)
}

fn learnable_move_decoder() {
  dynamic.decode1(LearnableMove, dynamic.field("move", resource_info_decoder()))
}

/// A Pokemon
pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    base_experience: Int,
    stats: List(Stat),
    moves: List(LearnableMove),
  )
}

pub fn pokemon_decoder() {
  dynamic.decode5(
    Pokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("stats", dynamic.list(stat_decoder())),
    dynamic.field("moves", dynamic.list(learnable_move_decoder())),
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
    type_: ResourceInfo,
    damage_class: ResourceInfo,
  )
}

pub fn move_decoder() {
  dynamic.decode8(
    Move,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("accuracy", dynamic.optional(dynamic.int)),
    dynamic.field("pp", dynamic.int),
    dynamic.field("priority", dynamic.int),
    dynamic.field("power", dynamic.optional(dynamic.int)),
    dynamic.field("type", resource_info_decoder()),
    dynamic.field("damage_class", resource_info_decoder()),
  )
}

/// A Pokemon with all its move details
pub type PokemonWithMoves {
  PokemonWithMoves(pokemon: Pokemon, moves: List(Move))
}
