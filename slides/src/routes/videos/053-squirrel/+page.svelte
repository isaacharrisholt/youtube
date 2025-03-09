<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import message_animation from '$lib/animations/message.json'
	import plug_animation from '$lib/animations/plug.json'
	import knowledge_owl_animation from '$lib/animations/knowledge-owl.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'
	import { fade } from 'svelte/transition'

	let slide_2_code_el: Code

	let slide_9_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="sql"
				theme="catppuccin-mocha"
				code={`
create type pokemon_type as enum ('fire', 'water', 'grass', 'dark', 'flying');

create table pokemon (
	id int not null primary key,
	name text not null,
	primary_type pokemon_type not null,
	secondary_type pokemon_type,
	coolness_factor int
);
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn get_coolest_pokemon(conn: pog.Connection, pokemon_type: String) {
	pog.query("
		select id, name
		from pokemon
		where primary_type = $1
			or secondary_type = $1
		order by coolness_factor desc
		limit 3
	")
	|> pog.parameter(pog.text(pokemon_type))
	|> pog.returning({
		use id <- decode.field(0, decode.int)
		use name <- decode.field(1, decode.string)
		#(id, name)
	})
  |> pog.execute(conn)	
}
				`.trim()}
				bind:this={slide_2_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_2_code_el.selectLines`3-8`
			}}
			undo={async () => {
				await slide_2_code_el.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				await slide_2_code_el.selectLines`10`
			}}
			undo={async () => {
				await slide_2_code_el.selectLines`3-8`
			}}
		/>

		<Action
			do={async () => {
				await slide_2_code_el.selectLines`11-15`
			}}
			undo={async () => {
				await slide_2_code_el.selectLines`10`
			}}
		/>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
get_coolest_pokemon(conn, "dark")
|> result.map(print_pokemon_names)
// zorua
// umbreon
// murkrow
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn get_coolest_pokemon(conn: pog.Connection, pokemon_type: String) {
	pog.query("
		select id, name
		from pokemon
		where primary_type = $1
			or secondary_type = $1
		order by coolness_factor desc
		limit 3
	")
	|> pog.parameter(pog.text(pokemon_type))
	|> pog.returning({
		use id <- decode.field(0, decode.int)
		use name <- decode.field(1, decode.string)
		#(id, name)
	})
  |> pog.execute(conn)	
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="sql"
				theme="catppuccin-mocha"
				code={`
select id, coolness_factor from pokemon
select coolness_factor, id from pokemon
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/squirrel-github.png" class="w-fit" />

			<h2>giacomocavalieri/squirrel</h2>
		</div>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code lang="bash" theme="catppuccin-mocha" code="gleam add --dev squirrel" />
		</div>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
src/
├── pokedex.gleam
└── pokedex/
    └── sql/
        └── get_coolest_pokemon.sql
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
src/
├── pokedex.gleam
└── pokedex/
    ├── items.gleam
    ├── items/
    │   └── sql/
    │       └── get_items.sql
    ├── moves.gleam
    └── moves/
        └── sql/
            └── get_moves.sql
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
src/
├── pokedex.gleam
└── pokedex/
    └── sql/
        └── get_coolest_pokemon.sql
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="sql"
				theme="catppuccin-mocha"
				code={`
-- get_coolest_pokemon.sql
select id, name
from pokemon
where primary_type = $1
	or secondary_type = $1
order by coolness_factor desc
limit 3

-- get_flying_pokemon.sql
select *
from pokemon
where primary_type = 'flying'
	and secondary_type is null
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<h2 class="font-mono">DATBASE_URL</h2>

		<p class="text-md">or</p>

		<div class="grid grid-cols-2">
			<div class="border-r-2 border-b-2 border-r-white border-b-white p-4 font-bold">Env var</div>
			<div class="border-b-2 border-b-white p-4 font-bold">Default</div>

			<div class="border-r-2 border-r-white p-4 font-mono">PGHOST</div>
			<div class="p-4 font-mono">localhost</div>

			<div class="border-r-2 border-r-white p-4 font-mono">PGPORT</div>
			<div class="p-4 font-mono">5432</div>

			<div class="border-r-2 border-r-white p-4 font-mono">PGUSER</div>
			<div class="p-4 font-mono">root</div>

			<div class="border-r-2 border-r-white p-4 font-mono">PGDATABASE</div>
			<div class="p-4 font-mono">&lt;gleam project name&gt;</div>

			<div class="border-r-2 border-r-white p-4 font-mono">PGPASSWORD</div>
			<div class="p-4 font-mono"></div>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code lang="bash" theme="catppuccin-mocha" code="gleam run -m squirrel" />
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
src/
├── pokedex.gleam
└── pokedex/
    ├── sql.gleam
    └── sql/
        └── get_coolest_pokemon.sql
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub type GetCoolestPokemonRow {
  GetCoolestPokemonRow(id: Int, name: String, primary_type: PokemonType)
}

pub fn get_coolest_pokemon(db, arg_1) {
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use primary_type <- decode.field(2, pokemon_type_decoder())
    decode.success(GetCoolestPokemonRow(id:, name:, primary_type:))
  }

  let query = "select id, name, primary_type
from pokemon
where primary_type = $1
  or secondary_type = $1
order by coolness_factor desc
limit 3;
"

  pog.query(query)
  |> pog.parameter(pokemon_type_encoder(arg_1))
  |> pog.returning(decoder)
  |> pog.execute(db)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub type PokemonType {
  Flying
  Dark
  Grass
  Water
  Fire
}

fn pokemon_type_encoder(variant) {
  case variant {
    Flying -> "flying"
    Dark -> "dark"
    Grass -> "grass"
    Water -> "water"
    Fire -> "fire"
  }
  |> pog.text
}

				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
sql.get_coolest_pokemon(conn, sql.Dark)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
Error: Invalid query [42601]

    ╭─ ./src/pokedex/sql/get_coolest_pokemon.sql
    │
  1 │ select id, name, primary_type,
  2 │ from pokemon
      ┬
      ╰─ syntax error at or near "from"
  3 │ where primary_type = $1
  4 │   or secondary_type = $1
  5 │ order by coolness_factor desc
  6 │ limit 3;
  7 │
    ┆
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code lang="bash" theme="catppuccin-mocha" code="gleam run -m squirrel --check" />
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/sponsorships/brilliant/qrcode.png" class="w-fit" />

			<h2>brilliant.org/IsaacHarrisHolt</h2>
			<h4>30 day free trial and 20% off an annual premium subscription</h4>
		</div>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div>
			<Code lang="sql" theme="catppuccin-mocha" code="alter type pokemon_type add value '1234';" />
		</div>

		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
Error: Query with invalid enum

    ╭─ ./src/pokedex/sql/get_coolest_pokemon.sql
    │
  1 │ select id, name, primary_type
  2 │ from pokemon
  3 │ where primary_type = $1
  4 │   or secondary_type = $1
  5 │ order by coolness_factor desc
  6 │ limit 3;
  7 │
    ┆

One of the values in this query is the \`pokemon_type\` enum, ...
        `.trim()}
			/>
		</div>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/jak-website.png" class="w-fit" />

			<h2>giacomocavalieri.me</h2>
		</div>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
