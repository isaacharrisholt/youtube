import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event

pub fn header() -> element.Element(a) {
  html.header([class("p-4 bg-red-500 text-white")], [
    html.h1([class("w-full mx-auto max-w-screen-xl text-4xl font-bold")], [
      html.text("Pokédex"),
    ]),
  ])
}

pub fn pokemon_search(
  value: String,
  on_input_msg: fn(String) -> a,
  on_click_msg: a,
) -> element.Element(a) {
  html.div([class("flex items-center flex-col sm:flex-row gap-2 sm:gap-0")], [
    html.input([
      attribute.placeholder("Search Pokémon"),
      attribute.type_("search"),
      attribute.value(value),
      class(
        "w-full p-2 flex-grow h-10 border-red-500 border-2 rounded-xl "
        <> "sm:rounded-r-none sm:border-r-0 focus-visible:outline-none "
        <> "focus-visible:ring-2 focus-visible:ring-red-500 "
        <> "focus-visible:ring-offset-2",
      ),
      event.on_keydown(fn(key) {
        case key {
          "Enter" -> on_click_msg
          _ -> on_input_msg(value)
        }
      }),
      event.on_input(on_input_msg),
    ]),
    html.button(
      [
        class(
          "w-full sm:w-fit bg-red-500 text-white text-semibold rounded-xl "
          <> "sm:rounded-l-none hover:bg-red-600 h-full p-2 "
          <> "focus-visible:outline-none focus-visible:ring-2 "
          <> "focus-visible:ring-red-500 focus-visible:ring-offset-2",
        ),
        event.on_click(on_click_msg),
      ],
      [html.text("Search")],
    ),
  ])
}
