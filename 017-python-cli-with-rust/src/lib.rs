use std::fs::File;

use csv;
use pyo3::exceptions::PyValueError;
use pyo3::prelude::*;

#[derive(Clone)]
#[pyclass(module = "csv_sum", get_all)]
struct FileTotal {
    path: String,
    total: f64,
}

#[pyclass(module = "csv_sum", get_all)]
struct CSVSum {
    total: f64,
    files: Vec<FileTotal>,
}

#[pymethods]
impl CSVSum {
    fn get_largest(&mut self, n: usize) -> PyResult<Vec<FileTotal>> {
        if n > self.files.len() {
            return Err(PyValueError::new_err("Can't return a list of more files than are available"));
        }

        self.files.sort_by(|a, b| a.total.partial_cmp(&b.total).unwrap());

        Ok(self.files[0..n].to_vec())
    }
}

fn sum_column(mut rdr: csv::Reader<File>, idx: usize) -> f64 {
    rdr.records()
        .map(|result| {
            let record = result.expect("Invalid result");
            let num_str = record.get(idx).unwrap();
            num_str.parse::<f64>().unwrap()
        })
        .sum()
}

/// Gets the sum of a column for multiple CSVs by the column header.
#[pyfunction]
fn sum_by_header(paths: Vec<&str>, header: &str) -> PyResult<CSVSum> {
    let totals: Vec<FileTotal> = paths
        .iter()
        .map(|&p| {
            let mut rdr = csv::Reader::from_path(p).expect("Unable to read file");

            let headers = rdr.headers().expect("Unable to read headers");

            let pos = headers
                .iter()
                .position(|h| h == header)
                .expect(&format!("Column \"{}\" does not exist", header));

            let file_sum = sum_column(rdr, pos);

            FileTotal {
                total: file_sum,
                path: p.to_string(),
            }
        })
        .collect();

    let total = totals
        .iter()
        .map(|t| t.total)
        .sum();

    Ok(CSVSum {
        total,
        files: totals,
    })
}

/// Gets the sum of a column for multiple CSVs by the column index.
#[pyfunction]
fn sum_by_index(paths: Vec<&str>, idx: usize) -> PyResult<CSVSum> {
    let totals: Vec<FileTotal> = paths
        .iter()
        .map(|&p| {
            let rdr = csv::ReaderBuilder::new()
                .has_headers(false)
                .from_path(p)
                .expect("Unable to read file");

            let file_sum = sum_column(rdr, idx);

            FileTotal {
                total: file_sum,
                path: p.to_string(),
            }
        })
        .collect();

    let total = totals
        .iter()
        .map(|t| t.total)
        .sum();

    Ok(CSVSum {
        total,
        files: totals,
    })
}

/// A Python module implemented in Rust.
#[pymodule]
fn _csv_sum(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_by_header, m)?)?;
    m.add_function(wrap_pyfunction!(sum_by_index, m)?)?;
    m.add_class::<CSVSum>()?;
    Ok(())
}
