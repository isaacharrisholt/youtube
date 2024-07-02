# Use THIS Language to Speed Up Your Python Code

Python's slowness can be fixed by extending it using other languages.
Previously, I've suggested Rust for the job. But is it really the best lang to pick?

## Running the code

Running the code here is a little tricky. The `.so` files here were compiled
for an x86 Ubuntu machine, so may not work on yours. The Rust examples for
`fib` and `primes` came from videos [010](../010-creating-python-packages-with-rust/)
and [015][../015-python-rust-and-c/] respectively, so you may need to compile
for your own machine.

The Nim code can be compiled using:

```bash
# Compile on Windows:
nim c --app:lib --out:mymodule.pyd --threads:on --tlsEmulation:off --passL:-static mymodule
# Compile on everything else:
nim c --app:lib --out:mymodule.so --threads:on mymodule
```

Then, copy the `.so` files into the correct directories, give them the correct names
and run the Python code!
