import app/cache.{type Cache}
import app/pokemon.{type Move, type Pokemon}

/// A simple context type that can be attached to
/// each request to provide access to the caches.
pub type Context {
  Context(
    pokemon_cache: Cache(Pokemon),
    move_cache: Cache(Move),
    battle_cache: Cache(Pokemon),
  )
}
