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

	let slide_16_code_el: Code
	let slide_21_code_el: Code
	let slide_27_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center text-left"></Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/gleam-dynamic-decode.png" class="w-fit" />

			<h2>hexdocs.pm/gleam_stdlib/gleam/dynamic/decode</h2>
		</div>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-7xl">let string_decoder: Decoder(String) = ...</h1>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let my_data: Dynamic = get_data_from_somewhere()

decode.run(my_data, decode.string)
// Result(String, List(DecodeError))
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
decode.string     // String
decode.int        // Int
decode.float      // Float
decode.bool       // Bool
decode.bit_array  // BitArray
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
decode.run(my_data, decode.list(decode.string))
// Result(List(String), List(DecodeError))
				`.trim()}
			/>
		</div>

		<Transition>
			<div>
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
decode.run(my_data, decode.dict(decode.string, decode.int))
// Result(Dict(String, Int), List(DecodeError))
				`.trim()}
				/>
			</div>
		</Transition>

		<Transition class="w-full">
			<div class="w-full">
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
decode.run(my_data, decode.optional(decode.string))
// Result(Option(String), List(DecodeError))
				`.trim()}
				/>
			</div>
		</Transition>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="flex flex-col gap-4">
			<p>Erlang</p>
			<div class="w-full">
				<Code
					lang="erlang"
					theme="catppuccin-mocha"
					code={`
nil
null
undefined
				`.trim()}
				/>
			</div>
		</div>

		<div class="flex flex-col gap-4">
			<p>JavaScript</p>
			<div class="w-full">
				<Code
					lang="javascript"
					theme="catppuccin-mocha"
					code={`
null
undefined
				`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-7xl">decode.at(List(a), Decoder(b)) -> Decoder(b)</h1>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
// {"ember": {"type": "fire"}}
decode.at(["ember", "type"], decode.string) // Gives "fire"
				`.trim()}
			/>
		</div>

		<Transition>
			<div class="w-full">
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
// [["king", "queen", "knight"], ["pawn", "pawn", "pawn"]]
decode.at([0, 2], decode.string) // "knight"
				`.trim()}
				/>
			</div>
		</Transition>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
// {"ember": {"type": "fire"}}
decode.optionally_at(["ember", "power"], decode.int) // Gives None
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/thumbnails/050.png" />
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type PokemonType {
	Fire
	Dark
	Dragon
	Steel
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center gap-4">
		<h1 class="font-mono text-7xl">"fire"</h1>
		<h1 class="font-mono text-7xl">"dark"</h1>
		<h1 class="font-mono text-7xl">"dragon"</h1>
		<h1 class="font-mono text-7xl">"steel"</h1>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
case pokemon_type_string {
	"fire" -> Fire
	"dark" -> Dark
	"dragon" -> Dragon
	"steel" -> Steel
	_ -> panic as "Unknown type!"
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center gap-4">
		<h1 class="font-mono text-7xl">decode.then(Decoder(a), fn(a) -> Decoder(b)) -> Decoder(b)</h1>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let pokemon_type_decoder = {
	use pokemon_type_string <- decode.then(decode.string)
}
				`.trim()}
				bind:this={slide_16_code_el}
			/>
		</div>

		<Action
			do={async () =>
				await slide_16_code_el!.update`let pokemon_type_decoder = {
	use pokemon_type_string <- decode.then(decode.string)
	case pokemon_type_string {
		"fire" -> decode.success(Fire)
		"dark" -> decode.success(Dark)
		"dragon" -> decode.success(Dragon)
		"steel" -> decode.success(Steel)
		_ -> decode.failure(Fire, "PokemonType")
	}
}`}
		/>

		<Transition>
			<div class="w-full">
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
let assert Ok(Fire) = decode.run(dynamic.from("fire"), pokemon_type_decoder)
				`.trim()}
				/>
			</div>
		</Transition>

		<Action do={async () => await slide_16_code_el!.selectLines`8`} />
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center text-white">
		<Img src="/logos/rover.svg" class="w-[70dvw] text-white" default />
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center gap-32">
		<div class="flex w-[70dvw] flex-wrap items-center justify-around gap-8">
			<Img src="/logos/javascript.png" class="max-h-[20dvh] w-fit" default />
			<Img src="/logos/typescript.svg" class="max-h-[20dvh] w-fit" default />
			<Img src="/logos/python.svg" class="max-h-[20dvh] w-fit" default />
		</div>

		<div class="flex w-[70dvw] flex-wrap items-center justify-between gap-8">
			<Img src="/logos/lucy/gleam-lucy.svg" class="max-h-[20dvh] w-fit -rotate-10" default />
			<Img src="/logos/go.svg" class="max-h-[20dvh] w-fit" default />
			<Img src="/logos/rust-logo-white.png" class="max-h-[20dvh] w-fit" default />
			<Img src="/logos/dart.png" class="max-h-[20dvh] w-fit" default />
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type PokemonNpc {
	GymLeader(
		name: String,
		location: #(Int, Int),
		speciality: PokemonType,
		tm_reward: Option(Int),
	)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"name": "Clair",
	"location": {"x": 154, "y": 27},
	"speciality": "dragon",
	"tm_reward": 24
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let gym_leader_decoder = {
	
}
				`.trim()}
				bind:this={slide_21_code_el}
			/>
		</div>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
}`}
		/>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use location <- decode.field("location", coordinate_decoder)
}`}
		/>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use x_coordinate <- decode.subfield(["location", "x"], decode.int)
	use y_coordinate <- decode.subfield(["location", "y"], decode.int)
}`}
		/>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use x_coordinate <- decode.subfield(["location", "x"], decode.int)
	use y_coordinate <- decode.subfield(["location", "y"], decode.int)
	use speciality <- decode.field("speciality", pokemon_type_decoder)
}`}
		/>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use x_coordinate <- decode.subfield(["location", "x"], decode.int)
	use y_coordinate <- decode.subfield(["location", "y"], decode.int)
	use speciality <- decode.field("speciality", pokemon_type_decoder)
	use tm_reward <- decode.optional_field(
		"tm_reward",
		None, // Our default value
		decode.optional(decode.int),
	)
}`}
		/>

		<Action
			do={async () =>
				await slide_21_code_el!.update`let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use x_coordinate <- decode.subfield(["location", "x"], decode.int)
	use y_coordinate <- decode.subfield(["location", "y"], decode.int)
	use speciality <- decode.field("speciality", pokemon_type_decoder)
	use tm_reward <- decode.optional_field(
		"tm_reward",
		None, // Our default value
		decode.optional(decode.int),
	)

	decode.success(
		GymLeader(
			name:,
			location: #(x_coordinate, y_coordinate),
			speciality:,
			tm_reward:,
		)
	)
}`}
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type PokemonNpc {
	GymLeader(
		name: String,
		location: #(Int, Int),
		speciality: PokemonType,
		tm_reward: Option(Int),
	)
 	Professor(name: String, home: String)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"name": "Clair",
	"location": {"x": 154, "y": 27},
	"speciality": "dragon",
	"tm_reward": 24
}
				`.trim()}
			/>
		</div>

		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"name": "Oak",
	"home": "Pallet Town"
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let pokemon_npc_decoder = decode.one_of(gym_leader_decoder, or: [
	professor_decoder,
])
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type PokemonNpc {
	GymLeader(
		name: String,
		location: #(Int, Int),
		speciality: PokemonType,
		tm_reward: Option(Int),
	)
 	Professor(name: String, home: String)
  NonTrainerNpc(name: String)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"type": "gym_leader",
	"name": "Clair",
	"location": {"x": 154, "y": 27},
	"speciality": "dragon",
	"tm_reward": 24
}
				`.trim()}
			/>
		</div>

		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"type": "professor",
	"name": "Oak",
	"home": "Pallet Town"
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let pokemon_npc_decoder = {
	use npc_type <- decode.field("type", decode.string)
	
	case npc_type {
		"gym_leader" -> gym_leader_decoder
		"professor" -> professor_decoder
		_ -> decode.failure(Professor(name: "", home: ""), "PokemonNpcType")
	}
}
				`.trim()}
				bind:this={slide_27_code_el}
			/>
		</div>

		<Action do={async () => await slide_27_code_el!.selectLines`7`} />
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let gym_leader_decoder = {
	use name <- decode.field("name", decode.string)
	use x_coordinate <- decode.subfield(["location", "x"], decode.int)
	use y_coordinate <- decode.subfield(["location", "y"], decode.int)
	use speciality <- decode.field("speciality", pokemon_type_decoder)
	use tm_reward <- decode.optional_field(
		"tm_reward",
		None, // Our default value
		decode.optional(decode.int),
	)
	
	decode.success(
		GymLeader(
			name:,
			location: #(x_coordinate, y_coordinate),
			speciality:,
			tm_reward:
		)
	)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="json"
				theme="catppuccin-mocha"
				code={`
{
	"location": {"x": 154, "y": 27},
	"speciality": "chaos"
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
Error([
	DecodeError("Field", "Nothing", ["name"]),
	DecodeError("PokemonType", "String", ["speciality"])
])
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn string_decoder() -> decode.Decoder(String) {
  decode.new_primitive_decoder("String", fn(data) {
    case decode.run(data, decode.string) {
      Ok(x) -> Ok(x)
      Error(_) -> Error("")
    }
  })
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/thumbnails/042.png" />
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let decoder = decode.one_of(decode.string, or: [
  decode.int |> decode.map(int.to_string),
  decode.float |> decode.map(float.to_string),
])
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn map_errors(
  decoder: Decoder(a),
  transformer: fn(List(DecodeError)) -> List(DecodeError),
) -> Decoder(a)
				`.trim()}
			/>
		</div>

		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let decoder = decode.string |> decode.collapse_errors("MyThing")
let result = decode.run(dynamic.from(1000), decoder)
assert result == Error([DecodeError("MyThing", "Int", [])])
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn cat_from_json(json_string: String) -> Result(Cat, json.DecodeError) {
  let cat_decoder = {
    use name <- decode.field("name", decode.string)
    use lives <- decode.field("lives", decode.int)
    use nicknames <- decode.field("nicknames", decode.list(decode.string))
    decode.success(Cat(name:, lives:, nicknames:))
  }
  json.parse(from: json_string, using: cat_decoder)
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center gap-16">
		<div class="w-full">
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let assert Ok(response) =
  pog.query(sql_query)
  |> pog.parameter(pog.int(1))
  |> pog.returning(row_decoder) // Decoder!
  |> pog.execute(db)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/screenshots/gleam-generate-dynamic-decoder-action.png" class="w-fit" />
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/squirrel-github.png" class="w-fit" />

			<h2>giacomocavalieri/squirrel</h2>
		</div>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
