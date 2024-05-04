import gleam/otp/actor
import gleam/erlang/process.{type Subject}
import gleam/dict.{type Dict}

const timeout = 3000

type Store(value) =
  Dict(String, value)

type Cache(value) =
  Subject(Message(value))

pub type Message(value) {
  Set(key: String, value: value)
  Get(reply_with: Subject(Result(value, Nil)), key: String)
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

pub fn shutdown(cache: Cache(value)) {
  process.send(cache, Shutdown)
}
