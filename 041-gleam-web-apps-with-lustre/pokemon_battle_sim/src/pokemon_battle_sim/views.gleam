import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/string
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event
import lustre/ui
import lustre/ui/button
import lustre/ui/layout/aside
import lustre/ui/layout/stack
import lustre/ui/util/cn.{bg_element, px_md}
import pokemon_battle_sim/types.{type CanLoad, LoadError, Loaded, Loading}
import pokemon_battle_sim/types/model.{type Model}
import pokemon_battle_sim/types/msg.{
  type Msg, UserClickedSearchButton, UserSelectedPokemon,
}
import pokemon_battle_sim/types/pokemon.{type Pokemon}

pub const pokemon_search_input_id = "pokemon-search-input"

pub fn header() -> element.Element(Msg) {
  ui.box([bg_element()], [
    html.h1([class("text-2xl font-bold")], [
      html.text("Pokémon Battle Simulator"),
    ]),
  ])
}

pub fn pokemon_search() -> element.Element(Msg) {
  html.div([px_md(), class("flex items-center flex-row gap-4")], [
    ui.input([
      attribute.id(pokemon_search_input_id),
      attribute.placeholder("Search Pokémon"),
      attribute.type_("search"),
      class("w-full flex-grow"),
    ]),
    ui.button(
      [
        button.primary(),
        class("w-fit"),
        event.on_click(UserClickedSearchButton),
      ],
      [html.text("Search")],
    ),
  ])
}

pub fn main_content(model: Model) -> element.Element(Msg) {
  html.main([], [
    ui.stack([], [
      pokemon_search(),
      ui.aside(
        [aside.content_last(), px_md()],
        pokemon_details(model.current_pokemon, model.all_pokemon),
        ui.stack(
          [stack.tight(), class("min-w-[20dvw]")],
          pokemon_list(model.all_pokemon),
        ),
      ),
    ]),
  ])
}

fn pokemon_list(
  pokemon: CanLoad(List(String), String),
) -> List(element.Element(Msg)) {
  case pokemon {
    Loaded(pokemon) ->
      list.map(pokemon, fn(p) {
        ui.button(
          [
            event.on_click(UserSelectedPokemon(string.lowercase(p))),
            button.soft(),
            button.small(),
            class("w-full text-left"),
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
    Loaded(None) -> html.p([], [html.text(message)])
    Loaded(Some(pokemon)) ->
      html.div([], [
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
