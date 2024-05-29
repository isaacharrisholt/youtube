import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event
import lustre/ui
import lustre/ui/button
import lustre/ui/layout/aside
import lustre/ui/layout/stack
import lustre/ui/util/cn.{bg_element, px_md}
import pokemon_battle_sim/types/model.{type Model}
import pokemon_battle_sim/types/msg.{type Msg, UserSelectedPokemon}
import pokemon_battle_sim/types/pokemon.{type Pokemon}

pub fn header() -> element.Element(a) {
  ui.box([bg_element()], [
    html.h1([class("text-2xl font-bold")], [
      html.text("Pokémon Battle Simulator"),
    ]),
  ])
}

pub fn pokemon_search() -> element.Element(a) {
  html.div([px_md(), class("flex items-center flex-row gap-4")], [
    ui.input([
      attribute.placeholder("Search Pokémon"),
      attribute.type_("search"),
      class("w-full flex-grow"),
    ]),
    ui.button([button.primary(), class("w-fit")], [html.text("Search")]),
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

fn pokemon_list(pokemon: List(String)) -> List(element.Element(Msg)) {
  list.map(pokemon, fn(p) {
    ui.button(
      [
        event.on_click(UserSelectedPokemon(p)),
        button.soft(),
        button.small(),
        class("w-full text-left"),
      ],
      [html.text(p)],
    )
  })
}

fn pokemon_details(
  maybe_pokemon: Option(Pokemon),
  all_pokemon: List(String),
) -> element.Element(Msg) {
  let message = case all_pokemon {
    [] -> "Search for a Pokémon to view details"
    _ -> "Select a Pokémon to view details"
  }
  case maybe_pokemon {
    None -> html.p([], [html.text(message)])
    Some(pokemon) ->
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
  }
}
