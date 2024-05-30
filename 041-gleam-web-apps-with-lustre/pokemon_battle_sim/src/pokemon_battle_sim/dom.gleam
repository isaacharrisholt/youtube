import plinth/browser/element

@external(javascript, "../priv/static/dom_ffi.mjs", "set_value")
pub fn set_value(element: element.Element, value: String) -> Nil
