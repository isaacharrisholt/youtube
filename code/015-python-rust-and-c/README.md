# Python, Rust and Why You No Longer Need C

Rust is slowly growing in popularity, and it's starting to take over Python
code too. This video discusses how Rust is being used more and more in Python
extensions, and may eventually replace C and C++ for that purpose.

## Running the Code

To run the code, first install `maturin` with `pip install maturin`. Then, from
the `primes` directory, run `maturin develop`. This will build the Rust code
and install the Python package in development mode in your current environment.
You can then run the benchmarks with `python primes.py <n>` where `n` is the
prime you want to benchmark for.

### My results

All results are in microseconds.

| n       | 10   | 100   | 1000   | 10,000 |
| ------- | ---- | ----- | ------ | ------ |
| Python  | 6.37 | 151.0 | 3223.7 | 79,308 |
| Rust    | 0.01 | 8.88  | 359.38 | 12,691 |
| Speedup | 637x | 17.0x | 8.97x  | 6.25x  |
