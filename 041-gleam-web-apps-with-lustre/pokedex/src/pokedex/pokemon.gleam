import gleam/dynamic

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

/// A Pokemon with all its move details
pub type Pokemon {
  Pokemon(id: Int, name: String, base_experience: Int, base_stats: Stats)
}

pub fn pokemon_decoder() -> fn(dynamic.Dynamic) ->
  Result(Pokemon, List(dynamic.DecodeError)) {
  dynamic.decode4(
    Pokemon,
    dynamic.field("id", dynamic.int),
    dynamic.field("name", dynamic.string),
    dynamic.field("base_experience", dynamic.int),
    dynamic.field("base_stats", stats_decoder()),
  )
}
