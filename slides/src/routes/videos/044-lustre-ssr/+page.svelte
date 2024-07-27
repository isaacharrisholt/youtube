<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Lottie from '$lib/lottie.svelte'
	import server_animation from '$lib/animations/server-rack.json'
	import update_animation from '$lib/animations/update.json'
	import api_animation from '$lib/animations/api.json'
	import html_animation from '$lib/animations/html.json'
	import copy_animation from '$lib/animations/copy.json'
	import { tween, all } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import PageSpeed from '$lib/page-speed.svelte'

	const SLIDE_1_DEFAULTS = {
		cycle_font: false
	}
	let slide_1 = $state({ ...SLIDE_1_DEFAULTS })

	const slide_4_left = tween(10, {
		duration: 1000,
		easing: cubicInOut
	})

	const slide_6_value_1 = tween(100, {
		duration: 1000,
		easing: cubicInOut
	})
	const slide_6_value_2 = tween(100, {
		duration: 1000,
		delay: 100,
		easing: cubicInOut
	})
	const slide_6_value_3 = tween(100, {
		duration: 1000,
		delay: 200,
		easing: cubicInOut
	})
	const slide_6_value_4 = tween(100, {
		duration: 1000,
		delay: 300,
		easing: cubicInOut
	})

	const slide_8_m_left = tween(0, {
		duration: 500,
		easing: cubicInOut
	})

	const SLIDE_16_DEFAULTS = {
		html_code_el: undefined as Code | undefined
	}
	let slide_16 = $state({ ...SLIDE_16_DEFAULTS })

	const slide_22_left = tween(0, {
		duration: 500,
		easing: cubicInOut
	})

	const SLIDE_31_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_31 = $state({ ...SLIDE_31_DEFAULTS })

	const SLIDE_34_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_34 = $state({ ...SLIDE_34_DEFAULTS })

	const SLIDE_40_DEFAULTS = {
		copy_blurred: true,
		show_copy: true,
		build_blurred: true,
		code_el: undefined as Code | undefined
	}
	let slide_40 = $state({ ...SLIDE_40_DEFAULTS })

	const SLIDE_46_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_46 = $state({ ...SLIDE_46_DEFAULTS })

	const SLIDE_52_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_52 = $state({ ...SLIDE_52_DEFAULTS })

	const SLIDE_53_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_53 = $state({ ...SLIDE_53_DEFAULTS })

	const SLIDE_57_DEFAULTS = {
		code_el: undefined as Code | undefined
	}
	let slide_57 = $state({ ...SLIDE_57_DEFAULTS })
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_1 = { ...SLIDE_1_DEFAULTS }
		}}
	>
		<h1 class="text-9xl font-bold">
			<span class:cycle-font={slide_1.cycle_font} style="animation-delay: 0s">S</span>
			<span class:cycle-font={slide_1.cycle_font} style="animation-delay: 0.25s">S</span>
			<span class:cycle-font={slide_1.cycle_font} style="animation-delay: 0.75s">R</span>
		</h1>

		<Action
			do={() => {
				slide_1.cycle_font = !slide_1.cycle_font
			}}
		/>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/php.svg" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/WXUFUZ5g7uUAAAAC/speed.gif" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 4 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_4_left.reset()
		}}
	>
		<div class="relative flex items-center justify-between gap-96">
			<Lottie animation={server_animation} class="h-80" />

			<img src="/logos/chrome.svg" alt="" class="w-64" />

			<div class="absolute top-0" style:left={$slide_4_left + 'rem'}>
				<Transition visible>
					<Lottie animation={update_animation} class="h-44" />
				</Transition>
			</div>
		</div>

		<Action
			do={async () => {
				await slide_4_left.to(37.5)
			}}
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/BllUamx5XkwAAAAC/blueberry-wonka.gif" alt="" />
	</Slide>

	<!-- 6 -->
	<Slide
		class="place-%content-center h-full place-items-center"
		out={() => {
			slide_6_value_1.reset()
			slide_6_value_2.reset()
			slide_6_value_3.reset()
			slide_6_value_4.reset()
		}}
	>
		<div class="flex items-center gap-36">
			<PageSpeed value={$slide_6_value_1} />
			<PageSpeed value={$slide_6_value_2} />
			<PageSpeed value={$slide_6_value_3} />
			<PageSpeed value={$slide_6_value_4} />
		</div>

		<Action
			do={async () => {
				await all(
					slide_6_value_1.to(29),
					slide_6_value_2.to(82),
					slide_6_value_3.to(54),
					slide_6_value_4.to(13)
				)
			}}
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition visible>
			<h1 class="mb-12 text-9xl font-bold">SSR</h1>
		</Transition>

		<Transition>
			<img src="https://media1.tenor.com/m/_ydT_dPwE8AAAAAd/watering-flower-thirsty.gif" alt="" />
		</Transition>
	</Slide>

	<!-- 8 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_8_m_left.reset()
		}}
	>
		<Transition>
			<img
				src="/logos/lucy/gleam-lucy.svg"
				alt=""
				class="w-[32rem]"
				style:margin-left={$slide_8_m_left + 'vw'}
				style:rotate={$slide_8_m_left - 10 + 'deg'}
			/>
		</Transition>

		<Action
			do={async () => {
				await slide_8_m_left.to(200)
			}}
		/>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExeTdtZXpxdnB0MTlwcHR4dnM2bWxoZWFybzk0OHhtbW5md21kZnFoMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/qgri3D9sTwCUGMcT8L/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/kqRFL07JgmAAAAAC/flab%C3%A9b%C3%A9-flabebe.gif" alt="" />
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/lucy/gleam-lucy-debug-fail.svg" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/the-elm-architecture.png" alt="" class="w-[1200px]" />
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/thumbnails/041.png" alt="" class="mb-12 w-full shadow-xl" />
		<h1 class="text-6xl font-bold">Create Robust Web Apps with Gleam and Lustre</h1>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/bVqS5cvX7pwAAAAd/the-office-michael-scott.gif" alt="" />
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-12 text-left text-8xl font-medium tracking-wide">
			<h1><span class="font-black">S</span>ingle</h1>
			<h1><span class="font-black">P</span>age</h1>
			<h1><span class="font-black">A</span>pps</h1>
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-12">
			<Transition visible>
				<div class="z-10 w-fit">
					<Code
						lang="html"
						class="w-fit"
						theme="catppuccin-mocha"
						code={`
<!DOCTYPE html>
<html lang="en">
  <head />
  <body>
    <div id="app"></div>
  </body>
</html>
				`.trim()}
						bind:this={slide_16.html_code_el}
					/>
				</div>
			</Transition>

			<Transition>
				<div class="w-full">
					<Code lang="text" class="w-full" theme="catppuccin-mocha" code="app.css" />
				</div>
			</Transition>

			<Transition>
				<div class="w-full">
					<Code lang="text" class="w-full" theme="catppuccin-mocha" code="app.mjs" />
				</div>
			</Transition>

			<Action
				do={async () => {
					await slide_16.html_code_el!.update`<!DOCTYPE html>
<html lang="en">
  <head />
  <body>
    <div id="app">
      <h1>Hello, world!</h1>
    </div>
  </body>
</html>`
				}}
			/>
		</div>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={api_animation} class="h-96" />
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMW1pOWg1cndqNWFmZ3R1cmpjZnlleTFjcDJ5YWdndzF5Mm5rZnJheSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/tmQrpA8zpG4a16SSxm/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="html"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
<noscript>
  <div class="alert">
    <h1>JavaScript is required to use this app.</h1>
    <p>Please enable JavaScript in your browser settings.</p>
  </div>
</noscript>
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://searchengineland.com/wp-content/seloads/2014/08/seo-idea-lightbulbs-ss-1920.jpg"
			alt=""
			class="shadox-md w-[48rem] rounded-xl"
		/>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/8Rbtq8LOHfwAAAAd/grade-stamp.gif" alt="" />
	</Slide>

	<!-- 22 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_22_left.reset()
		}}
	>
		<div class="relative flex items-center justify-between gap-96">
			<Lottie animation={server_animation} class="h-80" />

			<img src="/logos/chrome.svg" alt="" class="w-64" />

			<div class="absolute top-0" style:left={$slide_22_left + 'rem'}>
				<Transition visible>
					<Lottie animation={html_animation} class="h-44" />
				</Transition>
			</div>
		</div>

		<Action
			do={async () => {
				await slide_22_left.to(37.5)
			}}
		/>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeTl5N3V5bnA3YXJ2ZHN4c2dhMWZ0ajZzbmY5YW5hcW1zMGFqZjBzbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Ka2V8MODoM7vrUd7hm/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 24: Rendering our page HTML -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/wisp-cover.png" alt="" class="mb-12 w-[50vw] rounded-xl shadow-2xl" />
		<h1 class="font-mono text-6xl">gleam-wisp/wisp</h1>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXhpZzV6NWduaXF0ZXJ3aXgzZm1nZXFnZjI1YmN0MHFhcHBuYXN0MCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ycMyoblTi3nGGWnzrV/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit p-4 !text-6xl"
				theme="catppuccin-mocha"
				code="gleam add lustre"
			/>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/aTsxCf5envUAAAAd/caida-fall.gif" alt="" />
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="/screenshots/lustre-to-html-converter.png"
			alt=""
			class="mb-12 w-[50vw] rounded-xl shadow-xl"
		/>
		<h1 class="font-mono text-6xl">lpil/html-lustre-converter</h1>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/screenshots/lustre-page-scaffold.png" alt="" />
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcGVzMjRmbTZleGh6OHEzc2J6dGVkejRqamdtNHl0YTh1ZXdxaTR3NyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/N2JaONOG63aMM/giphy.webp"
			alt=""
			class="w-[50vw]"
		/>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-12">
			<div class="w-full">
				<Code
					lang="text"
					class="w-80 !leading-tight"
					theme="catppuccin-mocha"
					code={`
repo/
├── project_a/
└── project_b/
				`.trim()}
					bind:this={slide_31.code_el}
				/>
			</div>

			<Action
				do={async () => {
					await slide_31.code_el!.update`repo/
├── client/
└── server/`
				}}
			/>
		</div>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
		<h1 class="font-mono text-6xl">isaacharrisholt/youtube</h1>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit p-4 !text-6xl !leading-loose"
				theme="catppuccin-mocha"
				code={`
request("/subscribe")
|> post(you)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-12">
			<Transition visible>
				<div class="w-full">
					<Code
						lang="toml"
						class="w-full"
						theme="catppuccin-mocha"
						code={`
[dependencies]
gleam_stdlib = "~> 0.34 or ~> 1.0"
# ...
lustre = ">= 4.3.1 and < 5.0.0"
client = { path = "../client" }
				`.trim()}
						bind:this={slide_34.code_el}
					/>
				</div>
			</Transition>

			<Action
				do={async () => {
					await slide_34.code_el!.selectLines`5`
				}}
			/>

			<Transition>
				<div class="w-full">
					<Code
						lang="text"
						class="w-full !leading-tight"
						theme="catppuccin-mocha"
						code={`
repo/
├── client/
└── server/
    └── gleam.toml
    			`.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit p-4 !text-6xl"
				theme="catppuccin-mocha"
				code="gleam deps update"
			/>
		</div>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/tVy1iyr9AMQAAAAC/mr-bean-thumbs-up.gif"
			alt=""
			class="w-[50vh]"
		/>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/XQLVLptLIBEAAAAd/maes-b-lost-in-a-field.gif"
			alt=""
			class="w-[50vh]"
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/8ZzMFRsV58MAAAAC/youve-been-served-mcjuggernuggets.gif"
			alt=""
			class="w-[50vw]"
		/>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/Pas_bgTFBX4AAAAC/harrison-ford-staring.gif"
			alt=""
			class="w-[50vw]"
		/>
	</Slide>

	<!-- 40 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_40 = { ...SLIDE_40_DEFAULTS, code_el: slide_40.code_el }
		}}
	>
		<div class="flex items-center justify-between gap-32">
			{#if slide_40.show_copy}
				<Transition visible>
					<div
						class:blur-xl={slide_40.copy_blurred}
						class="w-fit transition-all duration-300 ease-in-out"
					>
						<Lottie animation={copy_animation} class="h-96" />
					</div>
				</Transition>
			{/if}

			<Transition visible>
				<div
					class="w-fit transition-all duration-300 ease-in-out"
					class:blur-xl={slide_40.build_blurred}
				>
					<Code
						lang="bash"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code="gleam run -m lustre/dev build"
						bind:this={slide_40.code_el}
					/>
				</div>
			</Transition>

			<Action
				do={async () => {
					slide_40.copy_blurred = false
				}}
			/>

			<Transition
				do={async () => {
					slide_40.build_blurred = false
					slide_40.show_copy = false
				}}
			/>

			<Action
				do={async () => {
					slide_40.code_el!.update`gleam run -m lustre/dev build --outdir=/priv`
				}}
			/>

			<Action
				do={async () => {
					slide_40.code_el!.selectToken`--outdir=/priv`
				}}
			/>
		</div>
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExamxsZGRvNWM1aGk3OXMxMnpzbWtoYjBtN3NnZWQ5NmVtemh0bzd6ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/nrXif9YExO9EI/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExcHZqY3J3MHd4dmMwdWRmeXJlOXpycjh1c3U3cm8wczl4a2cxdWgxayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/9o9dh1JRGThC1qxGTJ/giphy.webp"
			alt=""
			class="w-[40vw]"
		/>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/hckC4-rXFxIAAAAd/meme-puzzle.gif" alt="" />
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/CeY5T_QDMekAAAAC/pokemon-anime.gif"
			alt=""
			class="w-[50vw]"
		/>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/_ydT_dPwE8AAAAAd/watering-flower-thirsty.gif" alt="" />
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="json"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`{ "current_pokemon": "zorua" }`}
				bind:this={slide_46.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_46.code_el!.update`<​script id="model" type="application/json">
  { "current_pokemon": "zorua" }
</script>`
			}}
		/>

		<Action
			do={async () => {
				await slide_46.code_el!.update`{ "current_pokemon": "zorua" }`
			}}
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/qhCxxfVk6QMAAAAC/based-hack.gif" alt="" class="w-[50vw]" />
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
pub type Model {
  // ...
}

pub fn model_decoder() {
  // ...
}

pub fn model_encoder() {
  // ...
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/rRkuzxG-jVoAAAAd/sweeping-cleaning.gif" alt="" />
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-12">
			<Transition>
				<div class="w-full">
					<Code
						lang="gleam"
						class="w-[60vw]"
						theme="catppuccin-mocha"
						code={`
pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    base_experience: Int,
    base_stats: Stats,
    moves: List(Move),
  )
}
				`.trim()}
					/>
				</div>
			</Transition>

			<Transition>
				<div class="w-full">
					<Code
						lang="gleam"
						class="w-[60vw]"
						theme="catppuccin-mocha"
						code={`
pub type Pokemon {
  Pokemon(id: Int, name: String, base_experience: Int, base_stats: Stats)
}
					`.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/Eo6pFHjtakMAAAAd/baywatch-on-my-way.gif" alt="" />
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="text"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
repo/
├── client/
└── server/
    			`.trim()}
				bind:this={slide_52.code_el}
			/>

			<Action
				do={async () => {
					await slide_52.code_el!.update`repo/
├── client/
├── server/
└── shared/`
				}}
			/>
		</div>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`import server/pokemon.{Pokemon}`}
				bind:this={slide_53.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_53.code_el!.update`import shared/pokemon.{Pokemon}`
			}}
		/>
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/xXk7Hf_ufxcAAAAd/feel-so-clean-like-a-monkey-machine.gif"
			alt=""
		/>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/STewTAE3eCYAAAAC/fancy-woody.gif" alt="" />
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-6xl font-bold">SSR 🤝 CSR</h1>
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="dockerfile"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
FROM ghcr.io/gleam-lang/gleam:v1.3.2-erlang-alpine

WORKDIR /build

COPY ./client /build/client
COPY ./server /build/server
RUN mkdir -p /build/server/priv

# Compile frontend
RUN cd /build/client \\
  && gleam clean \\
  && gleam deps download \\
  && gleam run -m lustre/dev build --outdir=/build/server/priv

# Compile the project
RUN cd /build/server \\
  && gleam export erlang-shipment \\
  && mv build/erlang-shipment /app \\
  && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
				`.trim()}
				bind:this={slide_57.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_57.code_el!.selectLines`1`
			}}
		/>

		<Action
			do={async () => {
				await slide_57.code_el!.selectLines`9-13`
			}}
		/>

		<Action
			do={async () => {
				await slide_57.code_el!.selectLines`15-19`
			}}
		/>

		<Action
			do={async () => {
				await slide_57.code_el!.selectLines`21-24`
			}}
		/>

		<Action
			do={async () => {
				await slide_57.code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.tenor.com/m/hWtovfyLjNAAAAAd/captain-planet-let-our-powers-combine.gif"
			alt=""
		/>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/kqXJzGr5cnIAAAAd/simpol-khaby-lame.gif" alt="" />
	</Slide>

	<!-- 60 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>

<style>
	.cycle-font {
		animation: cycle-font-animation 1s infinite;
	}

	@keyframes cycle-font-animation {
		0% {
			font-family: serif;
		}
		25% {
			font-family: sans-serif;
		}
		50% {
			font-family: cursive;
		}
		75% {
			font-family: monospace;
		}
		100% {
			font-family: serif;
		}
	}
</style>
