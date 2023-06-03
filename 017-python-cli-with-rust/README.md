# Advanced PyO3: Creating A Python CLI With RUST

I've banged on about how great Python and Rust are together, so it's time for
me to finally show you how it's done! This video will cover more advanced uses
of PyO3 and Maturin as we create an epic CLI tool using the Typer library.

## Running the Code

To run the code, first install `maturin` with `pip install maturin`. Then run
`maturin develop`. This will build the Rust code and install the Python package
in development mode in your current environment.

You can then run the CLI tool with `csvsum -h col_1 "./data/headers/*.csv"
-l 10`.
