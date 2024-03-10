// rustimport:pyo3

//:
//: [dependencies]
//: markdown = "0.3.0"

extern crate markdown;
use pyo3::prelude::*;

#[pyfunction]
fn render_markdown(input: &str) -> PyResult<String> {
    Ok(markdown::to_html(input))
}

// Uncomment the below to implement custom pyo3 binding code. Otherwise,
// rustimport will generate it for you for all functions annotated with
// #[pyfunction] and all structs annotated with #[pyclass].
//
//#[pymodule]
//fn markdown(_py: Python, m: &PyModule) -> PyResult<()> {
//    m.add_function(wrap_pyfunction!(say_hello, m)?)?;
//    Ok(())
//}
