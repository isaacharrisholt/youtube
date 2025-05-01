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
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="flex flex-col items-center gap-16">
			<div class="grid grid-cols-2 gap-x-16 gap-y-4">
				<p>LambdaConf US<br />Estes Park, Colorado</p>
				<p>12-13th May, 2025</p>

				<p class="col-span-full text-center text-3xl">
					Use code <span class="font-semibold text-[#ffaff3]">ISAACHARRISHOLT</span> for 15% off!
				</p>
			</div>

			<div class="grid w-full grid-cols-2 gap-16">
				<p>Code BEAM Lite<br />Stockholm, Sweden</p>
				<p>2nd June, 2025</p>

				<p>Lambda Days 2025<br />Kraków, Poland</p>
				<p>12-13th June, 2025</p>
			</div>
		</div>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-16">
			<Img src="/logos/codecrafters.png" class="h-48 w-fit" default />
			<p class="text-9xl">CodeCrafters</p>
		</div>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex items-center gap-32">
			<Img
				src="https://images.chesscomfiles.com/uploads/v1/images_users/tiny_mce/CHESScom/phpyyRnHb.png"
				class="h-[512px]"
			/>

			<p class="whitespace-nowrap font-mono text-9xl">--&gt;</p>

			<p class="whitespace-nowrap text-9xl">d6</p>
		</div>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="http"
				theme="catppuccin-mocha"
				code={`
POST /move

{
  "fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
  "turn": "white",
  "failed_moves": ["Nf3"]
}

// 200 OK
// "e4"
`.trim()}
			/>
		</div>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/chess-tournament-github.png" class="w-fit" />

			<h2>isaacharrisholt/gleam-chess-tournament</h2>
		</div>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="grid w-full grid-cols-2 gap-16">
			<p>&nbsp;</p>
			<p></p>

			<p>&nbsp;</p>
			<p></p>

			<p>&nbsp;</p>
			<p></p>

			<p>Most interesting solution</p>
			<p>$50, t-shirt OR mug</p>
		</div>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="flex flex-col items-center gap-8">
			<Img src="/screenshots/gleam-shop.png" class="w-fit" />

			<h2>shop.gleam.run</h2>
		</div>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="grid w-full grid-cols-2 gap-16">
			<p>&nbsp;</p>
			<p></p>

			<p>&nbsp;</p>
			<p></p>

			<p>3rd place</p>
			<p>$100, t-shirt OR mug</p>

			<p>Most interesting solution</p>
			<p>$50, t-shirt OR mug</p>
		</div>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="grid w-full grid-cols-2 gap-16">
			<p>&nbsp;</p>
			<p></p>

			<p>2nd place</p>
			<p>$300, t-shirt OR mug</p>

			<p>3rd place</p>
			<p>$100, t-shirt OR mug</p>

			<p>Most interesting solution</p>
			<p>$50, t-shirt OR mug</p>
		</div>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="grid w-full grid-cols-2 gap-16">
			<p>1st place</p>
			<p>$500, t-shirt and mug</p>

			<p>2nd place</p>
			<p>$300, t-shirt OR mug</p>

			<p>3rd place</p>
			<p>$100, t-shirt OR mug</p>

			<p>Most interesting solution</p>
			<p>$50, t-shirt OR mug</p>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<h2>buttondown.com/gleamchess</h2>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center text-left">
		<div class="flex flex-col items-center gap-12">
			<h2 class="text-8xl">Deadline</h2>
			<h2>12pm UTC, 8th June, 2025</h2>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="rounded-full bg-red-600 py-6 px-12 text-6xl font-bold text-white shadow-xl">
			Subscribe
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-16">
			<Img src="/logos/codecrafters.png" class="h-48 w-fit" default />
			<p class="text-9xl">CodeCrafters</p>
		</div>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Img src="/screenshots/codecrafters-sponsor-page.png" class="h-[70vh] w-fit" />
			<h2>ihh.dev/codecrafters</h2>
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
