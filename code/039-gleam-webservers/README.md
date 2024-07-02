# Why you should be writing webservers in Gleam

Modern software engineering can be a bit of a nightmare. You've got all these different
third-party services to keep track of, and often many first-party microservices too! As
it turns out, things can be made more simple using Gleam. Let me show you how.

Thanks to CodeCrafters for sponsoring this video! Level up your coding skills:
https://ihh.dev/codecrafters

## Running the code

Ensure you have Gleam and Erlang installed on your system. You can find instructions
for installing Gleam [here](https://gleam.run/getting-started/installing/).

Then:

```bash
cd pokemon_battle_api
gleam run
```

The API will run on port 8000.

Battles will take place in the background every 10 seconds between every pair
of Pokemon in the cache.

## Endpoints

Both endpoints are implemented as GET endpoints.

| Path                    | Description                             |
|-------------------------|-----------------------------------------|
| `/pokemon/:name`        | Returns information about a Pokemon.    |
| `/battle/:name1/:name2` | Simulates a battle between two Pokemon. |

## Seeding the cache

Run `./seed.sh <number>` to seed Pokemon into the cache and watch the battles
happen in the background. Battles will also then be cached for later retrieval.
