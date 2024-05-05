//// The cache module provides a simple key-value store that can be used to cache
//// values in memory. The cache is implemented as an actor that can be interacted
//// with using messages. The cache can be used to store any type of value.
////
//// The cache runs in a separate process rather than being passed around as a
//// value. This allows the cache to be shared between multiple processes simply
//// without having to worry about synchronization and copying.

import gleam/dict.{type Dict}
import gleam/erlang/process.{type Subject}
import gleam/otp/actor
import gleam/string

const timeout = 3000

/// A simple type alias for a store of values.
type Store(value) =
  Dict(String, value)

/// A type alias for a Gleam subject used to interact
/// with the cache actor.
pub type Cache(value) =
  Subject(Message(value))

/// Messages that can be sent to the cache actor.
pub type Message(value) {
  Set(key: String, value: value)
  Get(reply_with: Subject(Result(value, Nil)), key: String)
  GetKeys(reply_with: Subject(List(String)))
  Shutdown
}

/// Handle messages sent to the cache actor.
fn handle_message(
  message: Message(value),
  store: Store(value),
) -> actor.Next(Message(value), Store(value)) {
  case message {
    Shutdown -> actor.Stop(process.Normal)
    Set(key, value) -> {
      let store = dict.insert(store, key, value)
      actor.continue(store)
    }
    Get(client, key) -> {
      process.send(client, dict.get(store, key))
      actor.continue(store)
    }
    GetKeys(client) -> {
      process.send(client, dict.keys(store))
      actor.continue(store)
    }
  }
}

/// Create a new cache.
pub fn new() -> Result(Subject(Message(value)), actor.StartError) {
  actor.start(dict.new(), handle_message)
}

/// Set a value in the cache.
pub fn set(cache: Cache(value), key: String, value: value) {
  process.send(cache, Set(key, value))
}

/// Get a value from the cache.
pub fn get(cache: Cache(value), key: String) -> Result(value, Nil) {
  actor.call(cache, Get(_, key), timeout)
}

/// Get all keys in the cache.
pub fn get_keys(cache: Cache(value)) -> List(String) {
  actor.call(cache, GetKeys, timeout)
}

/// Shutdown the cache.
pub fn shutdown(cache: Cache(value)) {
  process.send(cache, Shutdown)
}

/// Create a composite key from a list of keys.
pub fn create_composite_key(keys: List(String)) -> String {
  string.join(keys, ":")
}
