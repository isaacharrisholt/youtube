import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event
import pokedex/types/model.{type Model}
import pokedex/types/msg.{
  type CanLoad, type Msg, LoadError, Loaded, Loading, UserClickedSearchButton,
  UserSelectedPokemon, UserUpdatedPokemonSearchTerm,
}
import pokedex/types/pokemon.{type Pokemon}

pub fn header() -> element.Element(Msg) {
  html.header([class("p-4 bg-red-500 text-white")], [
    html.h1([class("w-full mx-auto max-w-screen-xl text-4xl font-bold")], [
      html.text("Pokédex"),
    ]),
  ])
}

pub fn main_content(model: Model) -> element.Element(Msg) {
  html.main([class("px-4")], [
    html.div([class("flex flex-col gap-8 w-full max-w-screen-xl mx-auto")], [
      pokemon_search(model),
      html.div([class("flex flex-col-reverse sm:flex-row gap-16 w-full")], [
        pokemon_details(model.current_pokemon, model.all_pokemon),
        html.div(
          [class("flex flex-col gap-4 min-w-[25dvw] lg:min-w-[20dvw]")],
          pokemon_list(model.all_pokemon),
        ),
      ]),
    ]),
  ])
}

fn pokemon_search(model: Model) -> element.Element(Msg) {
  html.div([class("flex items-center flex-col sm:flex-row gap-2 sm:gap-0")], [
    html.input([
      attribute.placeholder("Search Pokémon"),
      attribute.type_("search"),
      attribute.value(model.pokemon_search),
      class(
        "w-full flex-grow h-10 border-red-500 border-2 sm:border-r-0 sm:rounded-r-none rounded-xl p-2 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-500",
      ),
      event.on_input(UserUpdatedPokemonSearchTerm),
    ]),
    html.button(
      [
        class(
          "w-full sm:w-fit bg-red-500 text-white text-semibold rounded-xl sm:rounded-l-none hover:bg-red-600 h-full p-2 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-red-500",
        ),
        event.on_click(UserClickedSearchButton),
      ],
      [html.text("Search")],
    ),
  ])
}

fn pokemon_details(
  maybe_pokemon: CanLoad(Option(Pokemon), String),
  all_pokemon: CanLoad(List(String), String),
) -> element.Element(Msg) {
  let message = case all_pokemon {
    Loaded([]) -> "Search for a Pokémon to view details"
    Loaded(_) -> "Select a Pokémon to view details"
    LoadError(err) -> "Error loading Pokémon: " <> err
    Loading -> "Loading Pokémon selection..."
  }
  case maybe_pokemon {
    Loaded(None) -> html.p([class("flex-grow")], [html.text(message)])
    Loaded(Some(pokemon)) ->
      html.div([class("flex-grow")], [
        html.h2([], [html.text(pokemon.name)]),
        html.p([], [html.text("HP: " <> int.to_string(pokemon.base_stats.hp))]),
        html.p([], [
          html.text("Attack: " <> int.to_string(pokemon.base_stats.atk)),
        ]),
        html.p([], [
          html.text("Defense: " <> int.to_string(pokemon.base_stats.def)),
        ]),
        html.p([], [
          html.text("Sp. Atk: " <> int.to_string(pokemon.base_stats.sp_atk)),
        ]),
        html.p([], [
          html.text("Sp. Def: " <> int.to_string(pokemon.base_stats.sp_def)),
        ]),
        html.p([], [
          html.text("Speed: " <> int.to_string(pokemon.base_stats.speed)),
        ]),
      ])
    LoadError(err) -> html.p([], [html.text("Error loading Pokémon: " <> err)])
    Loading -> html.p([], [html.text("Loading Pokémon...")])
  }
}

fn pokemon_list(
  pokemon: CanLoad(List(String), String),
) -> List(element.Element(Msg)) {
  case pokemon {
    Loaded(pokemon) ->
      list.map(pokemon, fn(p) {
        html.button(
          [
            event.on_click(UserSelectedPokemon(string.lowercase(p))),
            class(
              "w-full text-left bg-red-500 text-white text-semibold rounded-lg hover:bg-red-600 px-2 py-1",
            ),
          ],
          [html.text(p)],
        )
      })
    LoadError(err) -> [
      html.p([], [html.text("Error loading Pokémon: " <> err)]),
    ]
    Loading -> [html.p([], [html.text("Loading Pokémon...")])]
  }
}
