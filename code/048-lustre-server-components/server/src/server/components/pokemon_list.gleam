import gleam/erlang/process.{type Selector, type Subject}
import gleam/function
import gleam/int
import gleam/io
import gleam/json
import gleam/list
import gleam/option.{type Option, Some}
import gleam/otp/actor
import lustre
import lustre/server_component
import mist.{type WebsocketConnection, type WebsocketMessage}
import server/cache.{type Cache}
import shared/components/pokemon_list.{type Msg}
import shared/pokemon.{type Pokemon}
import youid/uuid

pub type PokemonList =
  Subject(lustre.Action(Msg, lustre.ServerComponent))

pub type ComponentState {
  ComponentState(component: PokemonList, id: String)
}

pub fn socket_init(
  _conn: WebsocketConnection,
  pokemon_cache: Cache(Pokemon),
  pokemon_lists: Cache(PokemonList),
) -> #(ComponentState, Option(Selector(lustre.Patch(Msg)))) {
  let self = process.new_subject()
  let pokemon =
    cache.get_values(pokemon_cache)
    |> list.sort(fn(a, b) { int.compare(a.id, b.id) })
  let pokemon_list_app = pokemon_list.app()
  let assert Ok(pokemon_list) = lustre.start_actor(pokemon_list_app, pokemon)
  let id = uuid.v4_string() |> io.debug

  process.send(
    pokemon_list,
    server_component.subscribe(id, process.send(self, _)),
  )
  cache.set(pokemon_lists, id, pokemon_list)

  #(
    ComponentState(pokemon_list, id),
    Some(process.selecting(process.new_selector(), self, function.identity)),
  )
}

pub fn socket_update(
  state: ComponentState,
  conn: WebsocketConnection,
  msg: WebsocketMessage(lustre.Patch(Msg)),
) {
  case msg {
    mist.Text(json) -> {
      let action = json.decode(json, server_component.decode_action)
      case action {
        Ok(action) -> process.send(state.component, action)
        Error(_) -> Nil
      }

      actor.continue(state)
    }
    mist.Binary(_) -> actor.continue(state)
    mist.Custom(patch) -> {
      let assert Ok(_) =
        patch
        |> server_component.encode_patch
        |> json.to_string
        |> mist.send_text_frame(conn, _)
      actor.continue(state)
    }
    mist.Closed | mist.Shutdown -> actor.Stop(process.Normal)
  }
}

pub fn socket_close(state: ComponentState, pokemon_lists: Cache(PokemonList)) {
  process.send(state.component, server_component.unsubscribe(state.id))
  cache.delete(pokemon_lists, state.id)
}
