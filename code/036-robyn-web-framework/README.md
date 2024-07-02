# You might never need Pandas again...

Rust is everywhere these days, and the Python ecosystem is oxidising more and more by
the day. This time, I'd like to show you Robyn, a FastAPI alternative that's taking
performance to the next level.

## Running the code

Create a virtual environment and install dependencies with Pip:

```bash
python -m venv .venv
source ./.venv/bin/activate # Unix
pip install -r requirements.txt
```

Run the Robyn CLI:

```bash
robyn app.py --dev --compile-rust-path .
```
