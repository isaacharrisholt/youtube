# The 5 Languages Making Python Code Faster

Sometimes, Python alone is just not good enough. You need that extra boost. That tiny
optimisation to get your programs running faster. Well, what if the solution was not
actually Python? What if you could improve your Python programs... with other
languages? This video cover 5 languages for speeding up your Python code.

## Running the code

Once you've compiled the code, run the script with Python:

```bash
python -m venv .venv
source ./.venv/bin/activate
pip install -r requirements.txt
python distance.py
```

Instructions for compiling the code is below:

### C

Run `setup_c.py`

### Rust

Install the Rust binary into your virtual environment using Maturin:

```bash
maturin develop --release
```

### Go

Install the requirements and build the binary:

```bash
go install golang.org/x/tools/cmd/goimports@latest
go mod init mymodule
go get github.com/go-python/gopy
gopy build -vm=python3 -output=distance_go ./go_src
```

### Julia

For the Julia code, you may need to follow the instructions in the video.

In the Julia REPL:

```julia
>>> import Pkg
>>> Pkg.add("PyCall")
```

In the Python REPL:

```python
>>> import julia
>>> julia.install()
```

### Nim

Compile the Nim module:

```bash
nim c --app:lib --out:distance.so -d:release distance.nim
```

## Benchmarks

Benchmark results are in [`results.csv`](./results.csv).
