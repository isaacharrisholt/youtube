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
import shared/pokemon.{type Pokemon, type_to_background, type_to_ring_colour}

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
    html.div(
      [
        class(
          [
            "flex flex-col gap-4 min-w-[25dvw] lg:min-w-[20dvw] overflow-y-auto overflow-x-hidden",
            "rounded-lg max-h-[23rem] md:max-h-[31rem] lg:max-h-[39rem]",
          ]
          |> string.join(" "),
        ),
      ],
      _,
    ),
    list.map(model, fn(pokemon) {
      #(pokemon.id |> int.to_string, pokemon_button(pokemon, on_click))
    }),
  )
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
          html.p([class("text-xs font-mono")], [
            html.text(
              "#" <> { pokemon.id |> int.to_string |> string.pad_left(4, "0") },
            ),
          ]),
        ]),
      ],
    ),
  ])
}
