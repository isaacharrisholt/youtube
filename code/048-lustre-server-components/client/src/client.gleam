import client/api.{type CanLoad, LoadError, Loaded, Loading, fetch_pokemon}
import client/shared.{header, pokemon_search}
import gleam/dynamic
import gleam/float
import gleam/int
import gleam/io
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string
import lustre
import lustre/attribute.{class}
import lustre/effect
import lustre/element
import lustre/element/html
import lustre/event
import lustre/server_component
import lustre_http
import plinth/browser/document
import plinth/browser/element as browser_element
import shared/components/pokemon_list
import shared/pokemon.{type Pokemon}

pub fn main() {
  let assert Ok(json_string) =
    document.query_selector("#model")
    |> result.map(browser_element.inner_text)

  let initial_pokemon =
    json.decode(json_string, dynamic.list(pokemon.pokemon_decoder()))
    |> result.unwrap([])
    |> io.debug

  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", initial_pokemon)

  Nil
}

pub type Model {
  Model(
    current_pokemon: CanLoad(Option(Pokemon), String),
    pokemon_search: String,
    all_pokemon: List(Pokemon),
  )
}

fn init(initial_pokemon: List(Pokemon)) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(
      current_pokemon: Loaded(None),
      pokemon_search: "",
      all_pokemon: initial_pokemon
        |> list.sort(fn(a, b) { int.compare(a.id, b.id) }),
    ),
    effect.none(),
  )
}

pub type Msg {
  UserSelectedPokemon(String)
  UserUpdatedPokemonSearchTerm(String)
  UserClickedSearchButton

  ApiReturnedPokemon(Result(Pokemon, lustre_http.HttpError))
}

pub fn view(model: Model) -> element.Element(Msg) {
  html.div([class("flex flex-col gap-12")], [
    header(),
    main_content(model.pokemon_search, model.current_pokemon, model.all_pokemon),
  ])
}

fn update(model: Model, msg: Msg) -> #(Model, effect.Effect(Msg)) {
  case msg {
    UserSelectedPokemon(pokemon_name) ->
      handle_user_selected_pokemon(model, pokemon_name)
    UserUpdatedPokemonSearchTerm(search_term) -> #(
      Model(..model, pokemon_search: search_term),
      effect.none(),
    )
    UserClickedSearchButton -> handle_user_clicked_search_button(model)

    ApiReturnedPokemon(Ok(pokemon)) -> #(
      Model(..model, current_pokemon: Loaded(Some(pokemon))),
      effect.none(),
    )
    ApiReturnedPokemon(Error(err)) -> {
      #(
        Model(
          ..model,
          current_pokemon: LoadError(
            "Error fetching Pokemon: " <> string.inspect(err),
          ),
        ),
        effect.none(),
      )
    }
  }
}

//
// Message handlers
//

fn handle_user_selected_pokemon(
  model: Model,
  pokemon_name: String,
) -> #(Model, effect.Effect(Msg)) {
  let fetch_effect = fetch_pokemon(pokemon_name, ApiReturnedPokemon)
  case model.current_pokemon {
    Loaded(Some(current_pokemon)) if current_pokemon.name == pokemon_name -> #(
      model,
      effect.none(),
    )
    Loaded(Some(current_pokemon)) -> #(
      Model(..model, current_pokemon: Loading(Some(current_pokemon))),
      fetch_effect,
    )
    Loading(_) -> #(model, fetch_effect)
    _ -> #(Model(..model, current_pokemon: Loading(None)), fetch_effect)
  }
}

fn handle_user_clicked_search_button(
  model: Model,
) -> #(Model, effect.Effect(Msg)) {
  let cleaned_pokemon_name =
    model.pokemon_search
    |> string.trim
    |> string.lowercase
  case string.trim(cleaned_pokemon_name) {
    "" -> #(model, effect.none())
    cleaned -> {
      let model = Model(..model, pokemon_search: "")
      handle_user_selected_pokemon(model, cleaned)
    }
  }
}

//
// UI bits
//
fn main_content(
  pokemon_search_term: String,
  current_pokemon: CanLoad(Option(Pokemon), String),
  all_pokemon: List(Pokemon),
) -> element.Element(Msg) {
  html.main([class("px-4 pb-24")], [
    html.div([class("flex flex-col gap-8 w-full max-w-screen-lg mx-auto")], [
      pokemon_search(
        pokemon_search_term,
        UserUpdatedPokemonSearchTerm,
        UserClickedSearchButton,
      ),
      html.div([class("flex flex-col-reverse sm:flex-row gap-16 w-full")], [
        pokemon_details(current_pokemon),
        element.element(
          "lustre-server-component",
          [
            server_component.route("/pokemon-list"),
            event.on("select", fn(v) {
              io.debug("Received pokemon list event")
              use name <- result.try(
                v |> dynamic.field(named: "detail", of: dynamic.string),
              )
              Ok(UserSelectedPokemon(name))
            }),
          ],
          [
            pokemon_list.prerender(all_pokemon, fn(pokemon) {
              UserSelectedPokemon(pokemon.name)
            }),
          ],
        ),
      ]),
    ]),
  ])
}

fn type_badge(pokemon_type: pokemon.PokemonType) -> element.Element(a) {
  html.div(
    [
      attribute.class(
        "flex items-center gap-2 rounded text-white px-2 py-1 font-mono font-semibold uppercase "
        <> pokemon.type_to_background(pokemon.Single(pokemon_type)),
      ),
    ],
    [html.text(pokemon_type |> pokemon.pokemon_type_to_string)],
  )
}

fn stat_bar(stat: Int, max: Int) -> element.Element(a) {
  let stat_percent =
    { int.to_float(stat) /. int.to_float(max) *. 100.0 }
    |> float.to_string
    |> io.debug

  html.div(
    [attribute.class("rounded bg-red-500 w-full overflow-hidden font-bold")],
    [
      html.div(
        [
          attribute.class("h-full rounded bg-green-500 p-2"),
          attribute.style([#("width", stat_percent <> "%")]),
        ],
        [html.text(stat |> int.to_string)],
      ),
    ],
  )
}

fn stat_grid(stats: pokemon.Stats) -> element.Element(a) {
  let max =
    [stats.hp, stats.atk, stats.def, stats.sp_atk, stats.sp_def, stats.speed]
    |> list.reduce(int.max)
    |> result.unwrap(255)

  html.div(
    [
      class(
        "grid grid-cols-[auto_1fr] gap-4 items-center text-sm font-mono font-semibold uppercase",
      ),
    ],
    [
      html.div([], [html.text("HP")]),
      stat_bar(stats.hp, max),
      html.div([], [html.text("Attack")]),
      stat_bar(stats.atk, max),
      html.div([], [html.text("Defense")]),
      stat_bar(stats.def, max),
      html.div([], [html.text("Sp. Atk")]),
      stat_bar(stats.sp_atk, max),
      html.div([], [html.text("Sp. Def")]),
      stat_bar(stats.sp_def, max),
      html.div([], [html.text("Speed")]),
      stat_bar(stats.speed, max),
    ],
  )
}

fn pokemon_details(
  maybe_pokemon: CanLoad(Option(Pokemon), String),
) -> element.Element(Msg) {
  let content = case maybe_pokemon {
    Loaded(None) ->
      html.p([], [html.text("Search for a Pokémon to view details")])
    Loaded(Some(pokemon)) | Loading(Some(pokemon)) ->
      html.div([class("flex flex-col gap-8")], [
        html.div([class("flex flex-col gap-2")], [
          html.div([class("flex gap-2 items-center")], [
            html.h2(
              [class("text-xl font-press-start-2p drop-shadow-lg uppercase")],
              [html.text(pokemon.name)],
            ),
            ..case maybe_pokemon {
              Loading(_) -> [
                html.p([class("font-mono animate-spin text-lg")], [
                  html.text("/"),
                ]),
              ]
              _ -> []
            }
          ]),
          html.p([class("font-mono")], [
            html.text(
              "#" <> { pokemon.id |> int.to_string |> string.pad_left(4, "0") },
            ),
          ]),
          html.div([class("flex gap-2")], case pokemon.types {
            pokemon.Single(type_) -> [type_badge(type_)]
            pokemon.Dual(type1, type2) -> [type_badge(type1), type_badge(type2)]
          }),
        ]),
        html.img([
          attribute.src(pokemon.artwork),
          attribute.class(
            "w-full md:w-1/2 rounded-lg drop-shadow-lg aspect-square",
          ),
        ]),
        stat_grid(pokemon.base_stats),
      ])
    Loading(None) -> html.p([], [html.text("Loading Pokémon...")])
    LoadError(err) -> html.p([], [html.text("Error loading Pokémon: " <> err)])
  }
  html.div([class("flex-grow")], [content])
}
