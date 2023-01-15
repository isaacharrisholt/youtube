# The Secret Weapon Every Software Engineer Needs

In this video, I talk about why you should learn SQL. I also talk about how to  
get started learning SQL, and what resources I recommend.

The code in this directory is a Python script that benchmarks two different
implementations of a function that finds users with failed orders for an online
store in a database.

For more information, watch the [video](https://youtu.be/G0DB5fVqbeg).

## Running the Code

First, you'll need to install the dependencies:

```bash
pip install -r requirements.txt
```

Then, you'll need to create a database. You can do this via Docker compose:

```bash
docker compose up -d
```

Finally, you can run the benchmark:

```bash
python3 main.py
```

Results will be printed to the console, and saved to the [`results`](./results)
directory.

## Resources

The SQL equivalent of the Python code in the video can be found in the
[`equivalent_sql.sql`](./equivalent_sql.sql) file.