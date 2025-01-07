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

	let slide_7_code_el: Code

	let slide_9_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type File(status) {
	File(path: String, permissions: Int)
}

type Open
type Closed
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
fn open(file: File(Closed)) -> File(Open) {
	// ...
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let file: File(Closed) = get_a_file()

let file = open(file)
open(file)
			  `.trim()}
			/>
		</div>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
error: Type mismatch
  ┌─ /home/my_project/src/my_project.gleam:5:8
  │
5 │   open(file)
  │        ^^^^

Expected type:

    File(Closed)

Found type:

    File(Open)
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
fn read(file: File(Open)) -> BitArray { ... }

fn write(file: File(Open), contents: BitArray) -> Int { ... }
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="rust"
				theme="catppuccin-mocha"
				code={`
use std::marker::PhantomData;

struct File<Status> {
	path: String,
	status: PhantomData<Status>
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let position_to_house_in_miles = 32
let house_to_horse_in_km = 14

let position_to_horse_via_house =
	position_to_house_in_miles + house_to_horse_in_km
            `.trim()}
				bind:this={slide_7_code_el}
			/>
		</div>

		<Action
			do={async () => {
				slide_7_code_el!.selectLines`5`
			}}
			undo={async () => {
				slide_7_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn pressure(v: Float, n: Float, r: Float, t: Float) -> Float {
	n .* r .* t ./ v
}
					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
type Distance(unit) {
	Distance(val: Int)
}

type Miles
type Kilometres

fn miles(value: Int) -> Distance(Miles) {
	Distance(value)
}

fn kilometres(value: Int) -> Distance(Kilometres) {
	Distance(value)
}

fn add(dist1: Distance(a), dist2: Distance(a)) -> Distance(a) {
	Distance(dist1.val + dist2.val)
}
				`.trim()}
				bind:this={slide_9_code_el}
			/>
		</div>

		<Action
			do={async () => {
				slide_9_code_el!.selectLines`8-14`
			}}
			undo={async () => {
				slide_9_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let position_to_house = miles(32)
let house_to_horse = kilometres(14)

let position_to_horse_via_house =
	add(position_to_house, house_to_horse)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="text"
				theme="catppuccin-mocha"
				code={`
error: Type mismatch
  ┌─ /my_project/src/my_project.gleam:5:60
  │
5 │   let position_to_horse_via_house = add(position_to_house, house_to_horse)
  │                                                            ^^^^^^^^^^^^^^

Expected type:

    Distance(Miles)

Found type:

    Distance(Kilometres)
    					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn miles_to_km(dist: Distance(Miles)) -> Distance(Kilometres) {
	int.to_float(dist.val)
	|> float.multiply(1.60943)
	|> float.round
	|> Distance
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let position_to_house = miles(32)
let house_to_horse = kilometres(14)

let position_to_horse_via_house =
	add(miles_to_km(position_to_house), house_to_horse)
	
position_to_horse_via_house
// ^? Distance(Kilometres)
			`.trim()}
			/>
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-7xl font-bold">Try anything once</h1>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8 font-bold">
			<Img
				src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZTJxdTlrbzRkcGZwaWh6MzJlZGk0dGZqenZhc2V1eG02bm95cWRwbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xjZtu4qi1biIo/giphy.webp"
			/>
			<p class="text-6xl">Free one month trial<br />for the first 500 people to join Skillshare</p>
			<p class="text-5xl">using my link in the description</p>
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let assert Ok(user) = get_user(user_age) // !!
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
type ResourceID(table) {
	ResourceID(String)
}

type User
type Repo
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn get_user(id: ResourceID(User)) -> Result(User, DbError) {
	// ...
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/pevensie-github.png" class="w-fit" />

			<h2>Pevensie/pevensie</h2>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn main() {
  let config = postgres.default_config()
  let driver = postgres.new_auth_driver(config)
  let pevensie_auth = auth.new(
    driver,
    user_metadata_decoder,
    user_metadata_encoder,
    "super secret cookie signing key",
  )
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
// Abridged...
pub opaque type PevensieAuth(connected) {
  PevensieAuth(driver: AuthDriver)
}				

pub fn connect(auth: PevensieAuth(Disconnected)) -> Result(PevensieAuth(Connected), Nil) { ... }

pub fn disconnect(auth: PevensieAuth(Connected)) -> Result(PevensieAuth(Disconnected), Nil) { ... }
        `.trim()}
			/>
		</div>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn add_kilometres(dist1: Distance(a), dist2: Distance(b)) -> Distance(Kilometres) {
	case dist1.phantom, dist2.phantom { // Doesn't exist!
	  // ...
	}
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<Transition visible>
			<div>
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code="let miles: Distance(Miles) = Distance(32)"
				/>
			</div>
		</Transition>

		<Transition>
			<div>
				<Code lang="gleam" theme="catppuccin-mocha" code="let file: File(Open) = File(...)" />
			</div>
		</Transition>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code="let dist: Distance(Pokemon) = Distance(570)"
			/>
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub opaque type Distance(units) {
	Distance(Int)
}
        `.trim()}
			/>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/hayleigh-phantom-types.png" class="w-fit" />

			<h2>blog.hayleigh.dev/phantom-types-in-gleam</h2>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
