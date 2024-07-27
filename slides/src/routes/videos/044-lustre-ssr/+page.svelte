<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Lottie from '$lib/lottie.svelte'
	import server_animation from '$lib/animations/server-rack.json'
	import update_animation from '$lib/animations/update.json'
	import api_animation from '$lib/animations/api.json'
	import html_animation from '$lib/animations/html.json'
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
