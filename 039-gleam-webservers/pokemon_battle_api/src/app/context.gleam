import app/cache.{type Cache}
import app/pokemon.{type Move, type Pokemon}

pub type Context {
  Context(pokemon_cache: Cache(Pokemon), move_cache: Cache(Move))
}
