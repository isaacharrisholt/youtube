import gleam/dict.{type Dict}
import gleam/erlang/process.{type Subject}
import gleam/otp/actor
import gleam/string

const timeout = 3000

type Store(value) =
  Dict(String, value)

pub type Cache(value) =
  Subject(Message(value))

pub type Message(value) {
  Set(key: String, value: value)
  Get(reply_with: Subject(Result(value, Nil)), key: String)
  GetKeys(reply_with: Subject(List(String)))
  Shutdown
}

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

pub fn new() -> Result(Subject(Message(value)), actor.StartError) {
  actor.start(dict.new(), handle_message)
}

pub fn set(cache: Cache(value), key: String, value: value) {
  process.send(cache, Set(key, value))
}

pub fn get(cache: Cache(value), key: String) -> Result(value, Nil) {
  actor.call(cache, Get(_, key), timeout)
}

pub fn get_keys(cache: Cache(value)) -> List(String) {
  actor.call(cache, GetKeys, timeout)
}

pub fn shutdown(cache: Cache(value)) {
  process.send(cache, Shutdown)
}

pub fn get_composite_key(keys: List(String)) -> String {
  string.join(keys, ":")
}
