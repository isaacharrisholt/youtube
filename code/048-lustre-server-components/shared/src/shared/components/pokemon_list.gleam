import gleam/int
import gleam/io
import gleam/json
import gleam/list
import gleam/string
import lustre
import lustre/attribute.{class}
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/event
import shared/pokemon.{type Pokemon}

pub fn app() {
  lustre.application(init, update, view)
}

pub fn prerender(model: Model, on_click: fn(Pokemon) -> a) -> element.Element(a) {
  render_pokemon_list(model, on_click)
}

pub type Msg {
  ServerAddedPokemon(Pokemon)
  UserSelectedPokemon(Pokemon)
}

type Model =
  List(Pokemon)

fn init(pokemon: List(Pokemon)) -> #(Model, effect.Effect(Msg)) {
  #(pokemon, effect.none())
}

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    ServerAddedPokemon(pokemon) -> {
      io.println("Add Pokemon: " <> pokemon.name)
      #(
        [pokemon, ..model]
          |> list.sort(fn(p1, p2) { int.compare(p1.id, p2.id) }),
        effect.none(),
      )
    }
    UserSelectedPokemon(pokemon) -> {
      #(model, event.emit("select", json.string(pokemon.name)))
    }
  }
}

fn view(model: Model) -> element.Element(Msg) {
  render_pokemon_list(model, UserSelectedPokemon)
}

fn render_pokemon_list(
  model: Model,
  on_click: fn(Pokemon) -> a,
) -> element.Element(a) {
  element.keyed(
    html.div([class("flex flex-col gap-4 min-w-[25dvw] lg:min-w-[20dvw]")], _),
    list.map(model, fn(pokemon) {
      #(pokemon.id |> int.to_string, pokemon_button(pokemon, on_click))
    }),
  )
}

fn type_to_background(pokemon_type: pokemon.PokemonTypes) -> String {
  let type_ = case pokemon_type {
    pokemon.Single(type_) -> type_
    pokemon.Dual(type1, _) -> type1
  }

  case type_ {
    pokemon.Bug -> "bg-bug"
    pokemon.Dark -> "bg-dark"
    pokemon.Dragon -> "bg-dragon"
    pokemon.Electric -> "bg-electric"
    pokemon.Fairy -> "bg-fairy"
    pokemon.Fighting -> "bg-fighting"
    pokemon.Fire -> "bg-fire"
    pokemon.Flying -> "bg-flying"
    pokemon.Ghost -> "bg-ghost"
    pokemon.Grass -> "bg-grass"
    pokemon.Ground -> "bg-ground"
    pokemon.Ice -> "bg-ice"
    pokemon.Normal -> "bg-normal"
    pokemon.Poison -> "bg-poison"
    pokemon.Psychic -> "bg-psychic"
    pokemon.Rock -> "bg-rock"
    pokemon.Steel -> "bg-steel"
    pokemon.Water -> "bg-water"
  }
}

fn type_to_ring_colour(pokemon_type: pokemon.PokemonTypes) -> String {
  let type_ = case pokemon_type {
    pokemon.Single(type_) -> type_
    pokemon.Dual(type1, _) -> type1
  }

  case type_ {
    pokemon.Bug -> "focus-visible:ring-bug"
    pokemon.Dark -> "focus-visible:ring-dark"
    pokemon.Dragon -> "focus-visible:ring-dragon"
    pokemon.Electric -> "focus-visible:ring-electric"
    pokemon.Fairy -> "focus-visible:ring-fairy"
    pokemon.Fighting -> "focus-visible:ring-fighting"
    pokemon.Fire -> "focus-visible:ring-fire"
    pokemon.Flying -> "focus-visible:ring-flying"
    pokemon.Ghost -> "focus-visible:ring-ghost"
    pokemon.Grass -> "focus-visible:ring-grass"
    pokemon.Ground -> "focus-visible:ring-ground"
    pokemon.Ice -> "focus-visible:ring-ice"
    pokemon.Normal -> "focus-visible:ring-normal"
    pokemon.Poison -> "focus-visible:ring-poison"
    pokemon.Psychic -> "focus-visible:ring-psychic"
    pokemon.Rock -> "focus-visible:ring-rock"
    pokemon.Steel -> "focus-visible:ring-steel"
    pokemon.Water -> "focus-visible:ring-water"
  }
}

pub fn pokemon_button(
  pokemon: Pokemon,
  on_click: fn(Pokemon) -> a,
) -> element.Element(a) {
  html.div([], [
    html.button(
      [
        event.on_click(on_click(pokemon)),
        class(
          [
            "w-full text-left text-white text-sm rounded-lg",
            "p-2 uppercase flex flex-row items-center gap-4",
            "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2",
            type_to_background(pokemon.types),
            type_to_ring_colour(pokemon.types),
            "hover:bg-opacity-80",
            "transition-colors duration-300 ease-in-out",
            "group",
          ]
          |> string.join(" "),
        ),
      ],
      [
        html.img([
          attribute.src(pokemon.sprite),
          attribute.class(
            "h-24 w-auto transform group-hover:scale-110 transition-transform duration-300 ease-in-out",
          ),
          attribute.alt(pokemon.name <> "'s sprite"),
        ]),
        html.div([class("flex flex-col gap-2")], [
          html.p([class("drop-shadow font-press-start-2p")], [
            html.text(pokemon.name),
          ]),
          html.p([class("text-xs")], [
            html.text(
              "#" <> { pokemon.id |> int.to_string |> string.pad_left(4, "0") },
            ),
          ]),
        ]),
      ],
    ),
  ])
}
