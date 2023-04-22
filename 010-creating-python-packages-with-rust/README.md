# How To Make Your Python Packages Really Fast With RUST

Everyone knows that program speed isn't Python's strong point. That's why so
many number-crunching data science libraries are written in C.

BUT C can cause headaches. Segfaults are common and memory leaks are something
to be feared. What if there was another option? Well, there is. It's Rust. Rust
is a blazingly fast, memory-efficient and memory-safe language that's an
absolute joy to work with. And I'm going to teach you how to use it to write
your Python packages.


## Running the Code

To run the code, first install `maturin` with `pip install maturin`. Then, from
the `fibbers` directory, run `maturin develop`. This will build the Rust code
and install the Python package in development mode in your current environment.
You can then run the benchmarks with `python fib.py`.
