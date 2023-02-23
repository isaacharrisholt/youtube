# Python - To OOP or to FP?

The debate between object-oriented programming and functional programming is one
of the most hotly-contested debates in history. In this video, we investigate
the differences and how you can combine the two paradigms in your Python code.

This directory contains four Python scripts. Three of them contain the same
program written in an OOP, an FP and a combined style. The last is a real-world
example of the combined style utilising Pydantic and FastAPI.

For more information, watch the [video](https://youtu.be/lNRBF6l8Jh4).

## Running the Code

First, you'll need to install the dependencies:

```bash
pip install -r requirements.txt
```

To run `oop.py`, `fp.py` or `combined.py`, run:

```bash
python3 <file>
```

To run the FastAPI example, run:

```bash
uvicorn real_world_example:app --reload --port 8000
```

Then, head to <http://localhost:8000/items/1>
