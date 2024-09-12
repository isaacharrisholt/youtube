# Slash Lustre Load Times with Server Side Rendering

Want to use server-side rendering (SSR) to speed up your Lustre apps? Here's how!

Check out Lustre: https://lustre.build/

Client-side rendering can be great, but it has some downsides when it comes to load times and SEO.
This video will show you how to use SSR and hydration in Lustre while keeping your code clean.

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
