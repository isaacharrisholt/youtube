import gleam/list
import gleam/option.{None}
import gleam/string
import lustre
import lustre/effect
import lustre/element
import lustre/ui
import lustre/ui/util/styles
import pokedex/api.{fetch_all_pokemon}
import pokedex/message_handlers.{
  handle_api_returned_pokemon_ok, handle_user_clicked_search_button,
  handle_user_selected_pokemon,
}
import pokedex/types/model.{type Model, Model}
import pokedex/types/msg.{
  type Msg, ApiReturnedAllPokemon, ApiReturnedPokemon, AppRequestedAllPokemon,
  LoadError, Loaded, Loading, UserClickedSearchButton, UserSelectedPokemon,
  UserUpdatedPokemonSearchTerm,
}
import pokedex/views.{header, main_content}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_flags) -> #(Model, effect.Effect(Msg)) {
  #(
    Model(
      current_pokemon: Loaded(None),
      all_pokemon: Loading,
      pokemon_search: "",
    ),
    fetch_all_pokemon(),
  )
}

fn view(model: Model) -> element.Element(Msg) {
  ui.stack([], [styles.elements(), header(), main_content(model)])
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

    AppRequestedAllPokemon -> #(
      Model(..model, all_pokemon: Loading),
      fetch_all_pokemon(),
    )

    ApiReturnedPokemon(Ok(pokemon)) ->
      handle_api_returned_pokemon_ok(model, pokemon)
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

    ApiReturnedAllPokemon(Ok(pokemon_names)) -> #(
      Model(
        ..model,
        all_pokemon: Loaded(
          pokemon_names
          |> list.sort(string.compare),
        ),
      ),
      effect.none(),
    )
    ApiReturnedAllPokemon(Error(err)) -> {
      #(
        Model(
          ..model,
          all_pokemon: LoadError(
            "Error fetching Pokemon: " <> string.inspect(err),
          ),
        ),
        effect.none(),
      )
    }
  }
}
