# Simple Realtime in Gleam with Lustre Server Components

Server components are a really cool way to create realtime experiences in Gleam. This
video will walk you through how to use them to create them using Lustre.

Check out Lustre: https://lustre.build/

## Running the code

Ensure you have Gleam and Erlang installed on your system. You can find instructions
for installing Gleam [here](https://gleam.run/getting-started/installing/).

Build the client artifacts:

```bash
cd client
gleam run -m lustre/dev build --outdir=../server/priv
```

Run the server:

```bash
cd server
gleam run
```

The server will be running on port 8000.
