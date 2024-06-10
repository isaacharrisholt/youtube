# Create Robust Web Apps in Gleam with Lustre

Software is becoming more type-safe, but web technologies are falling behind.
TypeScript alleviates some of the JavaScript woes, but it's still not enough. So what
do we do?

In this video, I'll show you how to build a completely type-safe web app in Gleam
using the Lustre framework.

Thanks to CodeCrafters for sponsoring this video! Level up your coding skills:
https://ihh.dev/codecrafters

## Running the code

Ensure you have Gleam and Erlang installed on your system. You can find instructions
for installing Gleam [here](https://gleam.run/getting-started/installing/).

Then, start the API:

```bash
cd pokemon_battle_api
gleam run
```

The API will run on port 8000.

You can then run the frontend:

```bash
cd pokedex
gleam run -m lustre/dev start
```

The web app will run on port 1234.

