import server/cache.{type Cache}
import server/components/pokemon_list.{type PokemonList}
import shared/pokemon.{type Move, type Pokemon}

/// A simple context type that can be attached to
/// each request to provide access to the caches.
pub type Context {
  Context(
    pokemon_cache: Cache(Pokemon),
    move_cache: Cache(Move),
    battle_cache: Cache(Pokemon),
    // Instead of keeping a single PokemonList component, we'll keep multiple
    // so eace person can have their own list of Pokemon, but we can update them
    // all at once.
    pokemon_lists: Cache(PokemonList),
  )
}
