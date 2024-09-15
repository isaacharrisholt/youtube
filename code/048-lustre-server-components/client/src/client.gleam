import client/api.{type CanLoad, LoadError, Loaded, Loading, fetch_pokemon}
import client/shared.{header, pokemon_search}
import gleam/dynamic
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
  let default_return = #(
    Model(..model, current_pokemon: Loading),
    fetch_pokemon(pokemon_name, ApiReturnedPokemon),
  )
  case model.current_pokemon {
    Loaded(Some(current_pokemon)) -> {
      case current_pokemon.name == pokemon_name {
        True -> #(model, effect.none())
        False -> default_return
      }
    }
    _ -> default_return
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
  html.main([class("px-4")], [
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

fn pokemon_details(
  maybe_pokemon: CanLoad(Option(Pokemon), String),
) -> element.Element(Msg) {
  let content = case maybe_pokemon {
    Loaded(None) ->
      html.p([], [html.text("Search for a Pokémon to view details")])
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
  html.div([class("flex-grow")], [content])
}
