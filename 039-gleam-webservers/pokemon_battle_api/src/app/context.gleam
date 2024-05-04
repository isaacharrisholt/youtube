import app/cache.{type Cache}
import app/pokemon.{type Move, type PokemonWithMoves}

pub type Context {
  Context(pokemon_cache: Cache(PokemonWithMoves), move_cache: Cache(Move))
}
