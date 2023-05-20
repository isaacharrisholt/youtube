use pyo3::exceptions::PyValueError;
use pyo3::prelude::*;

fn is_prime(num: u32) -> bool {
    for i in 2..=((num as f64).sqrt() as u32) {
        if num % i == 0 {
            return false;
        }
    }

    true
}

/// Calculate the nth prime number.
#[pyfunction]
fn nth_prime(n: u32) -> PyResult<u32> {
    if n < 1 {
        return Err(PyValueError::new_err("n must be a positive integer"));
    }

    let mut found = 0;
    let mut num = 1;

    while found < n {
        num += 1;
        if !is_prime(num) {
            continue;
        }

        found += 1;
    }
    Ok(num)
}

/// Fast prime number calculation
#[pymodule]
fn primes(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(nth_prime, m)?)?;
    Ok(())
}

