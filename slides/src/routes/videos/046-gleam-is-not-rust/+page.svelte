<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import balance_animation from '$lib/animations/balance.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'

	let slide_22_blur = $state(true)
	let slide_25_blur = $state(true)
	let slide_29_blur = $state(true)
	let slide_30_rust_code_el: Code | undefined
	let slide_58 = tween({ border: false, margin: -4 }, { duration: 500, easing: cubicInOut })
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbTZzM2ZhYm1renY4aGJ2Z3R6ZWQyNjF3cXg2eXl3emJjbjQ3ZjR0aCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1msB9qXRAk8a7JLiLD/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGRqZ2hjd2UwbWptbGswbDlkYzk3cDNwdjV4aGF4OWJzdHU4cmdkZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/TGcD6N8uzJ9FXuDV3a/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2ZiYWR0aDVjN3ZiaWl3d2h3NXRyN3pmbXI0cm1paW5zdDQ2eGRmdSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/rXfM5oNgqENj2/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/l4KiazyUi2YFBU02k/200.webp?cid=ecf05e47pr435bs79pgee41ywy0ev4vcjwe4g1zgf3rfkdto&ep=v1_gifs_search&rid=200.webp&ct=g"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXd3ejM3ZG04ZWVpazhhNGN0bmhzcDZiOWVhZXZwaW9xOHk0MDV6MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cEYFeDTFAdxw9vvYcXm/200.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExOTdoOTg5NzZ2aHFkc3AxdmxjMnMyd3ZkOHE2ZXF6Z3lqN3Fid2FvaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/TklowwY1vIeOr8jN2t/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzhrMDl4ZjI2N3U1OXY5djhhOG9heGFxMDIwZGJxbmh0cDg4bTJ2dSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/oEsUZ3jmzHGFi/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExaDR3dWdkemYzdDNtcTVyNnlxb2JqcnRpZGs5MWxjZmEwbWFrMjUxcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3ohzdHI7NgfDdiAmJy/giphy.webp"
			class="w-[50vw]"
		/>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExOXF1NjVnOHNjdG54ZDFpNTY5bnNpbTQzNmJnZGVycmMzYmdzcTlkcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/12bVDtXPOzYwda/200.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<Transition visible>
				<img src="/logos/lucy/gleam-lucy-happy.svg" alt="" class="w-[32rem] -rotate-10" />
			</Transition>

			<Transition>
				<img src="/logos/rust-logo-white.png" alt="" class="w-[32rem]" />
			</Transition>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-24">
			<Transition visible>
				<img src="/icons/hammer.svg" alt="" class="w-[24rem]" />
			</Transition>

			<Transition>
				<p class="font-mono text-9xl font-bold">!=</p>
			</Transition>

			<Transition visible>
				<img src="/icons/corkscrew.svg" alt="" class="w-[24rem]" />
			</Transition>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXIwbDl4ajk5dHJ1NHpmb3JnMjRneW5zaXRvNXMyb2hraG1zaWpsbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/veAy5UOhBdS3C/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-24">
			<img src="/icons/hammer.svg" alt="" class="w-[24rem]" />

			<p class="font-mono text-9xl font-bold">!=</p>

			<img src="/icons/corkscrew.svg" alt="" class="w-[24rem]" />
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmJ3dzduMXl6OGZhNDNtYjJoMjY2NHlxbWNlbjhjeWkzMHNjbm9oaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/a5viI92PAF89q/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbjN4dmxoM2w2OHRhanljbGowbDhkaDdhY3NuYnp0NW1xdWdtdHk3ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/6y6fyAD9OIE6NvhJEu/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[32rem] -rotate-10" />

			<p class="font-mono text-9xl font-bold">!=</p>

			<img src="/logos/rust-logo-white.png" alt="" class="w-[32rem]" />
		</div>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExb294OHh4bWMwM2JmYjFub2d0aXV6bXIyc21wNzcyaXEzMHUyNzAwZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bMyW51TS3QVVIPulMG/giphy.webp"
			class="h-[60vh]"
		/>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="rust"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
/// Pseudo code!
fn compile_gleam(src: String) -> Result<String, String> {
	let parsed = gleam::parser::parse(src);
	ast.to_erlang(parsed)
}
					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnJ3Z3o3azZwcXZ0d2NhcDM3dzZqcml0OGtrM2JzMXU2MDMyYm9iNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btSpeFqZTOFieQM/giphy.webp"
			class="h-[60vh]"
		/>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition>
			<div class="grid grid-cols-3 place-items-center gap-x-48 gap-y-16">
				<img src="/logos/python.svg" alt="" class="w-[16rem]" />
				<img src="/logos/java.png" alt="" class="row-span-2 w-[16rem]" />
				<img src="/logos/kotlin.png" alt="" class="w-[16rem]" />
				<img src="/logos/c-sharp.svg" alt="" class="w-[16rem]" />
				<img src="/logos/typescript.svg" alt="" class="w-[16rem]" />
			</div>
		</Transition>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZnMzdzFoaG1lNWpuMmsyMWIzZW44cnE2dmxlaXVveDNycWc1Y3dxcCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l36kU80xPf0ojG0Erg/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<h1 class="text-6xl font-bold">Commonalities</h1>

			<ul class="flex w-fit list-disc flex-col items-start gap-8 text-5xl">
				<li class:blur-xl={slide_22_blur} class="transition-all duration-500 ease-in-out">
					Syntax
				</li>
				<li class="blur-xl">Type system</li>
				<li class="blur-xl">Immutability</li>
			</ul>
		</div>

		<Action
			do={() => {
				slide_22_blur = false
			}}
		/>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Gleam</h1>
				<div class="w-fit">
					<Code
						lang="gleam"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
fn coin_flip() {
	let flip = case rand() > 0.5 {
		True -> "heads"
		False -> "tails"
	}

	io.println(flip)
}
					`.trim()}
					/>
				</div>
			</div>

			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Rust</h1>
				<div class="w-full">
					<Code
						lang="rust"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
fn coin_flip() {
  let flip = match rand() > 0.5 {
    true => "heads",
    false => "tails",
  };

  println!("{}", flip);
}
					`.trim()}
					/>
				</div>
			</div>
		</div>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<img src="/logos/f-sharp.png" alt="" class="w-[32rem]" />

			<img src="/logos/ocaml.svg" alt="" class="w-[32rem]" />
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<h1 class="text-6xl font-bold">Commonalities</h1>

			<ul class="flex w-fit list-disc flex-col items-start gap-8 text-5xl">
				<li>Syntax</li>
				<li class:blur-xl={slide_25_blur} class="transition-all duration-500 ease-in-out">
					Type system
				</li>
				<li class="blur-xl">Immutability</li>
			</ul>
		</div>

		<Action
			do={() => {
				slide_25_blur = false
			}}
		/>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Gleam</h1>
				<div class="w-fit">
					<Code
						lang="gleam"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
type Command {
	Move(Direction)
  ChangeColor(r: Int, g: Int, b: Int)
  Quit
}
					`.trim()}
					/>
				</div>
			</div>

			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Rust</h1>
				<div class="w-full">
					<Code
						lang="rust"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
enum Command {
  Move(Direction),
  ChangeColor(u8, u8, u8),
  Quit,
}
					`.trim()}
					/>
				</div>
			</div>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Gleam</h1>
				<div class="w-fit">
					<Code
						lang="gleam"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
case command {
	Move(direction) -> move(direction)
	ChangeColor(r, g, b) -> change_color(r, g, b)
	Quit -> quit()
}
						`.trim()}
					/>
				</div>
			</div>

			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Rust</h1>
				<div class="w-full">
					<Code
						lang="rust"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
match command {
  Command::Move(direction) => move(direction),
  Command::ChangeColor(r, g, b) => change_color(r, g, b),
  Command::Quit => quit(),
}
					`.trim()}
					/>
				</div>
			</div>
		</div>
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Gleam</h1>
				<div class="w-fit">
					<Code
						lang="gleam"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
type Result(ok, error) {
  Ok(ok)
  Error(error)
}
						`.trim()}
					/>
				</div>
			</div>

			<div class="flex flex-col gap-8">
				<h1 class="text-6xl font-bold">Rust</h1>
				<div class="w-full">
					<Code
						lang="rust"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
enum Result<T, E> {
  Ok(T),
  Err(E),
}
					`.trim()}
					/>
				</div>
			</div>
		</div>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<h1 class="text-6xl font-bold">Commonalities</h1>

			<ul class="flex w-fit list-disc flex-col items-start gap-8 text-5xl">
				<li>Syntax</li>
				<li>Type system</li>
				<li class:blur-xl={slide_29_blur} class="transition-all duration-500 ease-in-out">
					Immutability
				</li>
			</ul>
		</div>

		<Action
			do={() => {
				slide_29_blur = false
			}}
		/>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<Transition visible>
				<div class="flex flex-col gap-8">
					<h1 class="text-6xl font-bold">Gleam</h1>
					<div class="w-fit">
						<Code
							lang="gleam"
							class="w-fit !text-4xl"
							theme="catppuccin-mocha"
							code={`
let best_pokemon = "zorua"
best_pokemon = "pikachu" // Error!
						`.trim()}
						/>
					</div>
				</div>
			</Transition>

			<Transition>
				<div class="flex flex-col gap-8">
					<h1 class="text-6xl font-bold">Rust</h1>
					<div class="w-full">
						<Code
							lang="rust"
							class="w-full !text-4xl"
							theme="catppuccin-mocha"
							code={`
pokemon.iter()
  .filter(|pokemon| pokemon.is_legendary)
  .map(|pokemon| pokemon.name.to_lowercase())
	.collect::<Vec<String>>()
					`.trim()}
							bind:this={slide_30_rust_code_el}
						/>
					</div>
				</div>
			</Transition>
		</div>

		<Action
			do={async () => {
				await slide_30_rust_code_el!.update`let best_pokemon = "zorua"
best_pokemon = "pikachu" // Error!`
			}}
		/>

		<Action
			do={async () => {
				await slide_30_rust_code_el!.update`let mut best_pokemon = "zorua"
best_pokemon = "pikachu" // Ok!`
			}}
		/>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition>
			<Img src="/profile.jpg" class="h-[70vh]" />
		</Transition>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-60">
			<img src="/logos/x.png" alt="" class="w-[24rem]" />
			<img src="/logos/discord.svg" alt="" class="w-[32rem]" />
		</div>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZGhzbmZ2cjAwZmY2MXhkOWR5Zm5lNDZtYTV6aHAwZHZrOXh6d2h4ayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/VFvbRrV3Yrbj5tjzTb/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/rust-website.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">rust-lang.org</p>
		</div>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div class="w-fit">
				<Code
					lang="rust"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
use clap::Parser;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    name: String,

    #[arg(short, long, default_value_t = 1)]
    count: u8,
}
				`.trim()}
				/>
			</div>

			<div class="w-full">
				<Code
					lang="bash"
					class="w-full !text-4xl"
					theme="catppuccin-mocha"
					code="greet -n Isaac --count 2"
				/>
			</div>
		</div>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExOG90MnJ2YWxsZm1yazFod3hiMWIxMjQ2Njl4cWU5MGswb2Jqbm40bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/diQJ23WZ2FG14r8C38/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/gleam-website.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">gleam.run</p>
		</div>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/erlang-white.png" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExN3JlbW11bWVvbTByODcxeXhocWR5Z2JtMWU0bzliZ2JueWw4dGd2ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/krtDmVuQGssOtMWfRg/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/gleam-tour.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">tour.gleam.run</p>
		</div>
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdHh5NGxmdGxnbWE2Ym1nbWl3empreXdmNG1qODZ5c3o4dTdra2tnbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JEhCPFfqi2Hy8/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Transition visible>
				<Img src="/screenshots/gleam-videos.png" class="h-[70vh]" />
			</Transition>

			<Transition>
				<div class="rounded-full bg-red-600 py-6 px-12 text-6xl font-bold text-white shadow-xl">
					Subscribe
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<p class="text-7xl font-bold">Performance</p>
			<p class="text-5xl font-semibold">vs.</p>
			<p class="text-7xl font-bold">Productivity</p>
		</div>
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-3 place-items-center gap-32">
			<Transition>
				<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[24rem] -rotate-10" />
			</Transition>

			<img src="/logos/lucy/gleam-lucy-happy.svg" alt="" class="col-start-2 w-[32rem] -rotate-10" />

			<Transition>
				<img src="/logos/lucy/gleam-lucy-mail.svg" alt="" class="w-[32rem]" />
			</Transition>
		</div>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={balance_animation} class="h-[70vh]" />
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExdzY5d2JneHJpNGpqMm5oM2hyYmtkeDl6M2t3bGM1dDM1bm53OWRlcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/adG8jQ4ulQ34c/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-3 gap-16">
			{#each Array(9) as _, i (i)}
				<Img
					src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExdzY5d2JneHJpNGpqMm5oM2hyYmtkeDl6M2t3bGM1dDM1bm53OWRlcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/adG8jQ4ulQ34c/giphy.webp"
					class="h-full"
				/>
			{/each}
		</div>
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/erlang-beam-architecture.png" alt="" class="h-[70vh]" />
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
type Data(a) {
	Data(a)
}

fn function(data: Data) {
	todo
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExNmRtYXE1eDMzaTMzN3cxZ3d4Z216eXQ1MHZzYjYzcngzZ2tmaWwxbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/M66Rry93qU9XFIEIeZ/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/data-and-functions-article.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">mckayla.org</p>
		</div>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWkyNHNxbjRhcHk1cXlqdjd4cXl6ZWdtcWp3eWRuN3doejc5cmxjYyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/9uIGW7P8Ox6swA5Vw7/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/memes/async-teletubbies.webp" class="h-[70vh]" />
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="rust"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
fn call_on_ref_zero<F>(f: F)
	where F: for<'a> Fn(&'a i32) {
    let zero = 0;
    f(&zero);
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmg4ZmZoZjhwNHcya2wzOXg4bTZoMmc2cXkwcnVsYm5tdXcwY29paSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZYr1xhbD2EEu0YaukN/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbG5rZnM1dzYzMG93NXFnZXoxaTZrM3A3Z2xocjJiOGp3NzI5ZWZ5YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/HCX5kNR0RLmikUIKTa/giphy.webp"
			class="h-[60vh]"
		/>
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="text"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
$ cargo run
   Compiling message-passing v0.1.0 (file:///projects/message-passing)
error[E0382]: borrow of moved value: \`val\`
  --> src/main.rs:10:26
   |
8  |         let val = String::from("hi");
   |             --- move occurs because \`val\` has type \`String\`, which does not implement the \`Copy\` trait
9  |         tx.send(val).unwrap();
   |                 --- value moved here
10 |         println!("val is {val}");
   |                          ^^^^^ value borrowed here after move
   			`.trim()}
			/>
		</div>
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center">
			<Transition visible>
				<div
					class="grid aspect-square h-[70vh] place-items-center rounded-full border-2 transition-colors duration-500 ease-in-out"
					class:border-white={$slide_58.border}
					class:border-transparent={!$slide_58.border}
					style:margin-right="{$slide_58.margin}rem"
				>
					<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[20rem]" />
				</div>
			</Transition>

			<Transition visible>
				<div
					class="grid aspect-square h-[70vh] place-items-center rounded-full border-2 transition-colors duration-500 ease-in-out"
					class:border-white={$slide_58.border}
					class:border-transparent={!$slide_58.border}
					style:margin-left="{$slide_58.margin}rem"
				>
					<img src="/logos/rust-logo-white.png" alt="" class="w-[20rem]" />
				</div>
			</Transition>

			<Action
				do={async () => {
					await slide_58.to({ border: true })
				}}
			/>

			<Action
				do={async () => {
					await slide_58.to({ margin: 4 })
				}}
			/>
		</div>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="gleam run -m my-cli/greet -n Isaac --count 2"
			/>
		</div>
	</Slide>

	<!-- 60 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Transition visible>
				<h1 class="text-8xl font-bold line-through">Rewrite it in Rust</h1>
			</Transition>

			<Transition>
				<Img src="/thumbnails/010.png" class="h-[70vh]" />
			</Transition>
		</div>
	</Slide>

	<!-- 61 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDcxaGpqaHp0Z2JuMTRrcnNsczVtcDhhcTk3OWNmNWtyZzhqYjBrdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/uiC2Tho1u46mZxQTft/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 62 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdGN2c2N3Z3B1dDFvMGdkY2hiNGpxOXV0ejd2dnJ2ZGxiNmF0eXJ6OCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/NTur7XlVDUdqM/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 63 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDYydmxrbTJnczZ0ZXB5NTlxc2h6cjk3N3N6dTJ4ODk3bThya2RsbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LlC2k6LWvs3RVWLf6D/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 64 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/go.svg" alt="" class="h-[40vh]" />
	</Slide>

	<!-- 65 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExd2UxeWNjZnV3bWJsNTU0bG5kMTBjaHB3bDR6a2l4OW9lejVlOWh1ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gEvab1ilmJjA82FaSV/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 66 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXIyaGdxcnZyN2RydnN4dXdndGxtb2g0bnl6aWp1Y2pnZzd2dzhsMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT1XGOGdyDrL2BTfxK/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 67 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/complexity-vs-time-to-proficiency.png" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 68 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2szaDl1YjB4bHJzczdqamh1dWIzZTVpY3N1OHJ4bnVlOHY2eTh1cCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KanqCs2oHuzKYCXSXo/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 69 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/javascript.png" alt="" class="h-[70vh]" />
	</Slide>

	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbjdpZHF0bHVrOTk3bXV2aHdqMGl3ZWp6ZXB3aDRmdGRiY3RuM2JkciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ftAyb0CG1FNAIZt4SO/giphy.webp"
			class="h-[50vh]"
		/>
	</Slide>

	<!-- 70 -->
	<Slide class="h-full place-content-center place-items-center">
		<Stack class="relative">
			<Img
				src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ3JucjZ4Z2ZmZHI2YWNwdGdnZnlqMGdjYnk5OHozYW1rdnl2czhkbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Ru6g73N2ao9BjKFFLZ/giphy.webp"
				class="h-[70vh]"
			/>
			<img
				src="/logos/javascript.png"
				alt=""
				class="absolute top-[20%] left-1/2 h-64 -translate-x-1/2 rotate-5"
			/>
		</Stack>
	</Slide>

	<!-- 71 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/lucy/gleam-lucy-happy.svg" class="h-[70vh] -rotate-10" alt="" />
	</Slide>

	<!-- 72 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/rust-logo-white.png" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 73 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition>
			<div class="flex flex-row items-center gap-32">
				<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[32rem] -rotate-10" />

				<p class="font-mono text-9xl font-bold">!=</p>

				<img src="/logos/rust-logo-white.png" alt="" class="w-[32rem]" />
			</div>
		</Transition>
	</Slide>

	<!-- 74 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2x0bjF3Y283NWZtdm1nNXhienM0MzZzZDB4dnhrZ2Jxa29qNWd2byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/UevalSWg5twQeqpc8Q/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 75 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
