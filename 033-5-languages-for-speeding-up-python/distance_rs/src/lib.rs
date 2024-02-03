use pyo3::prelude::*;

#[pyfunction]
fn calculate_distance(coords: Vec<(f64, f64)>) -> PyResult<f64> {
    let mut total_distance = 0.0;

    if coords.len() < 2 {
        return Ok(total_distance);
    }

    for window in coords.windows(2) {
        let (x1, y1) = window[0];
        let (x2, y2) = window[1];
        let distance = ((x2 - x1).powi(2) + (y2 - y1).powi(2)).sqrt();
        total_distance += distance;
    }

    Ok(total_distance)
}

#[pymodule]
fn distance_rs(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(calculate_distance, m)?)?;
    Ok(())
}

