<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import message_animation from '$lib/animations/message.json'
	import plug_animation from '$lib/animations/plug.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'

	let slide_25_code_el: Code
	let slide_25_show_button = $state(true)
	let slide_27_code_el: Code
	let slide_36_code_el: Code
	let slide_38_code_el: Code
	let slide_44_code_el: Code
	let slide_45_code_el: Code
	let slide_50_code_el: Code
	let slide_64_code_el: Code
	let slide_69_code_el: Code
	let slide_83_code_el: Code
	let slide_87_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="https://m.media-amazon.com/images/I/61xfdABZkeL._SL1000_.jpg" />
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExZHJjbmZzNHVqYmtiNGY4eTR1M2Fhd2thcDRlbDdkamRuZmtobnJ6eSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/b7lp44pNiRqsU/giphy.webp"
		/>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGVkMXh4ZjF4bGFibjRma2xkMTBnamV0aGczenRuY2o0MXd5YjM3ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/PxSFAnuubLkSA/giphy.webp"
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/khchviG4Ypp8IbvAZX/giphy.webp?cid=790b7611p267cqpd00yf0ml5qpsjvcs9e4mh96ateowu0ptf&ep=v1_gifs_search&rid=giphy.webp&ct=g"
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjdxZGdqZTN1bDA5MXp4b3RrYXNmeDR0OXhqcGltNTB5ZnE3YmMyciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0HlMDr5SOKGpNu5a/giphy.webp"
		/>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2p3bnJ3bjg2bzQyZWd0bXNmeDF3ZjMzbm53M2E4MHZ4Y21kM3lidiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/GbIHIHhkgfpAs/giphy.webp"
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHBxM3Q4eDFlMm92anlzMXlleHNsMmYyZzZ2MWxobHRjcmhuYWllZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3oFzlY0DO131GoCFva/giphy.webp"
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2p3bnJ3bjg2bzQyZWd0bXNmeDF3ZjMzbm53M2E4MHZ4Y21kM3lidiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/GbIHIHhkgfpAs/giphy.webp"
		/>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="https://upload.wikimedia.org/wikipedia/commons/b/b8/Fortran_logo.svg" default />
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="f90"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
! compute factorials
do n = 1, 10
   nfact = nfact * n  
   ! printing the value of n and its factorial
   print*,  n, " ", nfact   
end do
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible>
				<div class="w-fit">
					<Code
						lang="python"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
for num in [1, 2, 3, 4, 5]:
    print(num)
				`.trim()}
					/>
				</div>
			</Transition>

			<Transition class="min-h-0 w-full">
				<div class="w-full">
					<Code
						lang="python"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
n = 0
while n < 5:
    print(n)
    n += 1
				`.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="ruby"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
until n >= 5
  puts n
  n += 1
end
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExOTg0cm94c2VldWhvcmZsZGhxejQ4OWcxZjlsOWVnem1mcmVtbG0yMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0HUhjsgv9MeeaqWY/giphy.webp"
		/>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHF6aW5vaDBlMDd2YXNha2MwcGl5d2pmbG9kZGRqZTFnZDc1ZTBqYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7btSlEkVbvtjkW3K/giphy.webp"
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnEyeDZndzNtdDl6aTh3OW00amQyaHRkeXAzdWYwNWgzczVodmU4ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/XBpUGMmoGM4DVHoRMZ/giphy.webp"
		/>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExODd1a2Y2MDVhOTVmNzJxam92bHJxbzk0Ym1wY3hra3FtZDh5MGZxciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/CLCT8BXR1T2oyBYilM/giphy.webp"
		/>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Functions</h1>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeWhsOW1pZHo1ajJpNGY2eHJzNzdzcjA4MDRtaGMyNjF6MTVucGJ5ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lPpKiZHB1PtQU2Rulv/giphy.webp"
		/>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExamx5M2h4MmtiMTZ2Y3hncW5jODFwcjEycG9xaGZ0dHVyb2E2MWt4ayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/PUITId5Avf9fLPpD3S/giphy.webp"
		/>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Recursion</h1>
		<h1 class="text-7xl font-bold opacity-60">Recursion</h1>
		<h1 class="text-4xl font-bold opacity-30">Recursion</h1>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExOG91Y2h2YnVreXN5Mm41YjFid2h5bGE3dHk2MXNoY2lra3BnbWZqeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LRNAO2LE6upSDUWBBa/giphy.webp"
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExazRkbWs2dnM4dnhyaG0yNm85YWgxNWxrdWI5M2NwajQ0OWFtbXZ2ZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BfHIMRAoD2iMx4wIpi/giphy.webp"
		/>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTh4ejBjOWpmOWlvN2oyZHM3amplN2hqZWNscmg3dnU5bDdpbHAyZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bnDYyn2HMzqpDEUecP/giphy.webp"
		/>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbHNhdTVvbW16ZXQxMWIxcHBhYXpxcml5Mmc5aHE5ZTU1dWJyYjNiZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/12nL3tvQyrg22c/giphy.webp"
		/>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="relative">
			<div class="w-fit">
				<Code
					lang="python"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
for num in [1, 2, 3, 4, 5]:
    result = fib(num)
    print(result)
				`.trim()}
					bind:this={slide_25_code_el}
				/>
			</div>

			{#if slide_25_show_button}
				<Img
					src="https://media1.tenor.com/m/7gUwUBvlgqAAAAAC/red-button-spam.gif"
					class="absolute top-12 right-4 h-[10vh] w-fit"
				/>
			{/if}
		</div>

		<Action
			do={async () => {
				slide_25_show_button = false
			}}
			undo={() => {
				slide_25_show_button = true
			}}
		/>

		<Action
			do={async () => {
				await slide_25_code_el!.selectLines`1`
			}}
			undo={() => {
				slide_25_code_el!.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				await slide_25_code_el!.selectLines`3`
			}}
			undo={() => {
				slide_25_code_el!.selectLines`1`
			}}
		/>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ3E1ZGIzcWJud2pzZHJtMHVrMHVsdzd3emRscmpta3NpcDF3bzJreSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cXblnKXr2BQOaYnTni/giphy.webp"
		/>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)
		`.trim()}
				bind:this={slide_27_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_27_code_el!.selectLines`4`
			}}
			undo={() => {
				slide_27_code_el!.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				await slide_27_code_el!.selectLines`2`
			}}
			undo={() => {
				slide_27_code_el!.selectLines`4`
			}}
		/>
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExOHV2MTZrbzRwcHc0cGdzcXl3eHI0emc3NzY0NHZkNWt2ZTIxbHQ5ciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l36kU80xPf0ojG0Erg/giphy.webp"
		/>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMHk4dnBxN2F0OTVncjRydnU3OTdlOTM5cmlwMXRncnZlczNscjdoaiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xThuWu82QD3pj4wvEQ/giphy.webp"
		/>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
n = 0
while true:
    result = fib(n)
    if result < -1:
        break
    print(result)
    n += 1
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMXRncjZxeTBqNDJ4MjE3bXZjZHZvcXJjeTFoeTBvaXc0NG9tNzZscCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8TweEdaxxfuElKkRxz/giphy.webp"
		/>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2YzbzkyZWx1dnUzYzRnNGF0bW1lMHd0ZHhyZXNpemVpdDBxOGV4ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1QhkRAFtcjO90zNZFi/giphy.webp"
		/>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div class="w-fit">
				<Code
					lang="python"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code="for i in range(10):"
				/>
			</div>

			<div class="w-fit">
				<Code
					lang="python"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code="while is_cool(pokemon):"
				/>
			</div>
		</div>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDhvbjNhbnJybmwxMDc0cmkzcW4xeTUzcW5qODhlYmJwcWk5MzJyOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xBIuPT5pjvarJZXyBw/giphy.webp"
		/>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdW9xNmN1eWNlZG56eWZsOGZ6ajN1ZmJkbmZyamR0aXozMHhjNWYxNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3oEdv5TKRImTqq6waA/giphy.webp"
		/>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)
				`.trim()}
				bind:this={slide_36_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_36_code_el!.selectLines`4`
			}}
			undo={() => {
				slide_36_code_el!.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				await Promise.all([
					slide_36_code_el!.update`def fib(n):
    if n <= 1:
        return n`,
					slide_36_code_el!.selectLines`*`,
				])
			}}
		/>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWhxdWJ1NGF1YXppamw5cjFhOTVjNHgzOW9tYmZrams5ZDU0c3R1YSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/YCZANZtsad5S6Qi2y7/giphy.webp"
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)
				`.trim()}
				bind:this={slide_38_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_38_code_el!.selectLines`2-3`
			}}
			undo={() => {
				slide_38_code_el!.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				await slide_38_code_el!.selectLines`3`
			}}
			undo={() => {
				slide_38_code_el!.selectLines`2-3`
			}}
		/>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeWhsOW1pZHo1ajJpNGY2eHJzNzdzcjA4MDRtaGMyNjF6MTVucGJ5ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lPpKiZHB1PtQU2Rulv/giphy.webp"
		/>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExajZjZ3U5cHFxZTMwZGtiaW52OGE5YTRhYXNhbHZqOHZkaHNocmp3MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Pqdu4u3nqLCTeKqjgc/giphy.webp"
		/>
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcnl6cTFma2MyNm1lbDd0Z3Vwc2NvdnJyZm9pbWV2NnduYjZsczl4NiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/2258qD1HRXhNmq6pGj/giphy.webp"
		/>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExOTZzbmpibnBoaG5vMXlkZ3kxbW1zeXFnMTY0NTJoa2FtYmhla21nbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Kvjugjvc1L9iE/giphy.webp"
		/>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<p>Flashback</p>
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div class="w-full">
				<Code
					lang="python"
					class="w-full !text-4xl"
					theme="catppuccin-mocha"
					code={`
for user in users:
    if user.is_admin:
        break
    `.trim()}
				/>
			</div>

			<h1 class="text-6xl font-bold">↓</h1>

			<div class="w-fit">
				<Code
					lang="gleam"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
fn get_admin(users: List(User)) -> Option(User) {
  case users {
    [user, ..rest] if user.is_admin -> Some(user)
    _ -> get_admin(rest)
  }
}
				`.trim()}
					bind:this={slide_44_code_el}
				/>

				<Action
					do={async () => {
						await slide_44_code_el!.selectLines`3`
					}}
					undo={() => {
						slide_44_code_el!.selectLines`*`
					}}
				/>
			</div>
		</div>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div class="w-full">
				<Code
					lang="python"
					class="w-full !text-4xl"
					theme="catppuccin-mocha"
					code={`
for user in users:
    if !user.is_admin:
        continue

    print(f'{user.name} is an admin')
    `.trim()}
				/>
			</div>

			<h1 class="text-6xl font-bold">↓</h1>

			<div class="w-fit">
				<Code
					lang="gleam"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
fn print_admins(users: List(User)) -> Option(User) {
  case users {
    [user, ..rest] if !user.is_admin -> print_admins(rest)
    [user, ..rest] -> {
      io.println(user.name <> " is an admin")
      print_admins(rest)
    }
 		[] -> Nil
  }
}
				`.trim()}
					bind:this={slide_45_code_el}
				/>

				<Action
					do={async () => {
						await slide_45_code_el!.selectLines`3`
					}}
					undo={() => {
						slide_45_code_el!.selectLines`*`
					}}
				/>
			</div>
		</div>
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmNzNjBudjM3YnUzN2U5MTg0c2ZuMzVuOXFsd2F5dDlhd2djZ2xkMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3ohhwoWSCtJzznXbuo/giphy.webp"
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
fn countdown(n: Int) {
	case n {
		0 -> io.println("Blastoff!")
		_ -> {
			io.println(int.to_string(n))
			countdown(n - 1)
		}
	}
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
n = 10
while n > 0:
    print(n)
    n -= 1

print("Blastoff!")
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExM29rcTRkNGZ6MHgyd296a2hqaWZobG4xeDcyamV6ZTRtam90OWh3cyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0HFiYHSQCRqcXRSM/giphy.webp"
		/>
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="rust"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
fn repeat(value, n, list) {
  case n <= 0 {
	  True -> list
	  False -> {
			let new_list = [value, ..list]
			repeat(value, n - 1, new_list)
		}
  }
}
				`.trim()}
				bind:this={slide_50_code_el}
			/>
		</div>

		<Action
			actions={[
				async () => await slide_50_code_el!.selectToken`value`,
				async () => await slide_50_code_el!.selectToken`n`,
				async () => await slide_50_code_el!.selectToken`list`,
				async () => await slide_50_code_el!.selectToken`list n`,
				async () => await slide_50_code_el!.selectLines`5`,
				async () => await slide_50_code_el!.selectLines`6`,
				async () => await slide_50_code_el!.selectLines`2`,
				async () => await slide_50_code_el!.selectLines`3`,
				async () => await slide_50_code_el!.selectLines`*`,
			]}
			undo={() => {
				slide_50_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjcweWxrODFhZmFkcGxpeGYxcm1zbThpeGw2NWhvZ2hhM2xqNGQ5MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/FfIp4kMKcU9LW/giphy.webp"
		/>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeWhsOW1pZHo1ajJpNGY2eHJzNzdzcjA4MDRtaGMyNjF6MTVucGJ5ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lPpKiZHB1PtQU2Rulv/giphy.webp"
		/>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExc3o3eWhvdW1ydmdqN2ZmOHhxeXVvaGV2Y2Jzb2hwODY3b2VyM3VucSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l3q2Ob7FHH1fKkLpm/giphy.webp"
		/>
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExOW1taTc2OHp2cTJydGFuaGwxN2F0bTFkNm42dmNsaTY4NnphaXBiMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/5B4Dl7V8cFaYo/giphy.webp"
		/>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/logos/lucy/gleam-lucy-happy.svg" class="h-[32rem] -rotate-10" default />
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Last Call Optimisation</h1>
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/diagrams/shared-linked-list.png" default />
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="rounded-full bg-red-600 py-16 px-16 text-9xl font-bold text-white">Subscribe</div>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExYWszd3l5a3ZreHZ3dGUxaHpzeXB4eHo1OTBiM2YyNXg5ZGoxdHQwZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/S2IfEQqgWc0AH4r6Al/giphy.webp"
		/>
	</Slide>

	<!-- 60 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHZ2dzRuaTA2d2x2b2VzajNrMnVlbGZhZm9tYmdsa2M2eG1oMHJvYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/13HgwGsXF0aiGY/giphy.webp"
		/>
	</Slide>

	<!-- 61 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-8 font-bold">
			<Img
				src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZTJxdTlrbzRkcGZwaWh6MzJlZGk0dGZqenZhc2V1eG02bm95cWRwbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xjZtu4qi1biIo/giphy.webp"
			/>
			<p class="text-6xl">Free one month trial<br />for the first 500 people to join Skillshare</p>
			<p class="text-5xl">using my link in the description</p>
		</div>
	</Slide>

	<!-- 62 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExMmcyc3prdW1uYWJ6bTZnOTZwaGpuNWp4a2Y2dDY2dXkwOHRmMWJ0diZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/XIqCQx02E1U9W/giphy.webp"
		/>
	</Slide>

	<!-- 63 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExd3B0dTB2cmVhOXEyazJnamg0bzRna2Rvb3Fpa3k5dmt5bHZqZ2NzbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/mFmuXkziY2RsQ/200.webp"
		/>
	</Slide>

	<!-- 64 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="python"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
def fib(n):
    try:
        return do_fib(n)
    except RecursionError:
        return "Too big!"

def do_fib(n):
    if n <= 1:
        return n
    return do_fib(n - 1) + do_fib(n - 2)
				`.trim()}
				bind:this={slide_64_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_64_code_el!.selectLines`1-5`
			}}
			undo={() => {
				slide_64_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 65 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl font-bold">Result(value, error)</h1>
	</Slide>

	<!-- 66 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/thumbnails/043.png" />
	</Slide>

	<!-- 67 -->
	<Slide class="h-full place-content-center place-items-center">
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
	</Slide>

	<!-- 68 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmw5OW0zaGQ0ODkyeDhnd25kZXFjZ252aTE5NWUzcHQyZ3ducHdsNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/giEftvZuPAiZQBphEI/giphy.webp"
		/>
	</Slide>

	<!-- 69 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
fn divide_all(numbers: List(Float), acc: Float) -> Result(Float, Nil) {
  case numbers {
    [0, ..] -> Error(Nil)
    [number, ..rest] -> {
      let new_acc = acc /. number
      divide_all(rest, new_acc)
    }
    [] -> Ok(acc)
  }
}
				`.trim()}
				bind:this={slide_69_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_69_code_el!.selectLines`3`
			}}
			undo={() => {
				slide_69_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 70 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMnRhdnc5cWtjZTFhZHBmc281dW4zdHcwbDltYm5leHFxZGpqdHZqaiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/11LK0CKzYtkaic/giphy.webp"
		/>
	</Slide>

	<!-- 71 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-24">
			<Transition visible>
				<h1 class="font-mono text-6xl font-bold">fn(state) -> List(Result(ok, error))</h1>
			</Transition>

			<Transition>
				<h1 class="font-mono text-6xl font-bold">fn(state) -> #(List(ok), List(error))</h1>
			</Transition>
		</div>
	</Slide>

	<!-- 72 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMWJzdWFmNTVxN2w1NXJtMzZmOHE0M2plZmowenJtNTQ1aWYwbTN2aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KGeqA1GqHBP2La5eSn/giphy.webp"
		/>
	</Slide>

	<!-- 73 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl font-bold">Monad</h1>
	</Slide>

	<!-- 74 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExczQwdncyOXBmdWgzanJ5dGIwb3MwbzAyeGptam52bG04M3dwOGUzdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0MYryZTmQgvHI5TG/giphy.webp"
		/>
	</Slide>

	<!-- 75 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExanB3c3RlNHZpbnl6cGFobnJjMGViNzE2bzQ4MnN3a29ramVpdHBjcCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/06ZxMyTNCiCmVzBkY4/giphy.webp"
		/>
	</Slide>

	<!-- 76 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
fn divide_all(numbers: List(Float), acc: Float) -> Result(Float, Nil) {
  case numbers {
    [0, ..] -> Error(Nil)
    [number, ..rest] -> {
      let new_acc = acc /. number
      divide_all(rest, new_acc)
    }
    [] -> Ok(acc)
  }
}
					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 77 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcXQ4dG5qdG9lbTV0aTRxZjB2cTJsaDZlcHRzMGd0MXZuZXVsYWxmdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT9IgkKL1SJVxzJSEg/giphy.webp"
		/>
	</Slide>

	<!-- 78 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Higher-order functions</h1>
	</Slide>

	<!-- 79 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3I3Zmh6aXpuc3pqODYzbW9hZ2RvNW16dG4wc3hqZGpjM3Q4N2dpNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lkdH8FmImcGoylv3t3/giphy.webp"
		/>
	</Slide>

	<!-- 80 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl font-bold">fn(fn() -> a) -> b</h1>
	</Slide>

	<!-- 81 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmFnOXU3ZXkzMzR1a3Z1dTJkY3FpbWo4c3NxNjQxeHF3b3g4Z2ZvMCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0HlMEi55YsfXyzMk/giphy.webp"
		/>
	</Slide>

	<!-- 82 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-6xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
[1, 2, 3, 4, 5]
|> list.map(fn(x) { x * 2 })
// [2, 4, 6, 8, 10]
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 83 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-6xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
[1, 2, 3, 4, 5]
|> list.fold(0, fn(acc, x) { acc + x })
// 15
				`.trim()}
				bind:this={slide_83_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_83_code_el!.selectLines`2`
			}}
			undo={() => {
				slide_83_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 84 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/logos/lucy/gleam-lucy-happy.svg" class="h-[32rem] -rotate-10" default />
	</Slide>

	<!-- 85 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="relative">
			<Img
				src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcGxwY2Y5bTllYWdqNHludGxzcWplb2g3MXd4eHc1dHZ2NnN2Mmc2OSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/6RIEW15CCWRvq/200.webp"
			/>
			<h1 class="absolute bottom-[7%] left-[57%] text-7xl font-bold">*</h1>
		</div>
	</Slide>

	<!-- 86 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2FpaTFkYmNrZXdvOW82d3doZzBxeHRieG15dGdoOXZ5N2lsanJraCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ftAyb0CG1FNAIZt4SO/giphy.webp"
		/>
	</Slide>

	<!-- 87 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
fn find(tree: Option(Tree(Email)), id: Int) -> Result(Email, Nil) {
	case tree {
	  Some(tree) -> case tree.value {
  		val if val == id -> Ok(tree.value)
  		val if val > id -> find(tree.lesser, looking_for)
  		_ -> find(tree.greater, looking_for)
  	}
  	None -> Error(Nil)
	}
}
				`.trim()}
				bind:this={slide_87_code_el}
			/>
		</div>

		<Action
			actions={[
				async () => await slide_87_code_el!.selectLines`5-6`,
				async () => await slide_87_code_el!.selectLines`4,8`,
			]}
			undo={() => {
				slide_87_code_el!.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 88 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMW45aGxuN3M1aGxrY3U5ZDI5ZXlnbnkza3ZhM3VyaWM2cHRrN2F2aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l49JXho10VKz27htK/giphy.webp"
		/>
	</Slide>

	<!-- 89 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExd2E3MmhqejJiNjVjdWRhb2ExZm44djdnYXgzbG5lN25jaWc4eXZ0OCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ounv1hey86r5DM6WhP/giphy.webp"
		/>
	</Slide>

	<!-- 90 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOXRqd21yOGQ2M3VubWxrcnJqemE1ZHlyc3VuMjJoZW9zZzk1eGliciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/aaODAv1iuQdgI/giphy.webp"
		/>
	</Slide>

	<!-- 91 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="mb-4 text-5xl font-bold">Me to my data:</h1>
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdGl5bWg0OGs1ZjY2Y2JhbGM3M2ZxYXlnY2J2eTlnaTF4ZTlub3JpNSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/6ipYoMZcShwstsgSY9/giphy.webp"
		/>
	</Slide>

	<!-- 92 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
fn delete(tree: Option(Tree(a))) {
  case tree {
    None -> None
    Some(tree) -> {
      let tree = option.unwrap(delete(tree.lesser), tree)
  		let tree = option.unwrap(delete(tree.greater), tree)
      Tree(..tree, lesser: None, greater: None)
    }
	}
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 93 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Post-order traversal</h1>
	</Slide>

	<!-- 94 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExejV0eWp0eTBmMjcxOHBrZHVuNXVoM2E3bXp4ZzFlZmd2NWczN2ZudCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/evNOxkX9EGnnAcBQTx/giphy.webp"
		/>
	</Slide>

	<!-- 95 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExYTN6cmszbWZpajFyZTl0NHQ3eWNpMGdrbTMxcmpzY2RvcTRuY3lhNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/MWNUrYYHUcoNBhwNBh/giphy.webp"
		/>
	</Slide>

	<!-- 96 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExZHdyeWh5bWN6OWZtem94N2pnOHp1eGcza2FqN2UzeTJ1aGYxYWE1byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKKhjIXevRnOKWY/giphy.webp"
		/>
	</Slide>

	<!-- 97 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnVieGZlZnBkc2ZkaGwwaW83YXNsZnN3MTA5czE4eDU3czgxZnBmciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l49JBYPXgnFwDkysw/giphy.webp"
		/>
	</Slide>

	<!-- 98 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZTRvcTI2ODZzN2l6cmNiMTN6c2E0cTNwZ2d3bXY1NGlyN3M1dmFpayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/dWSyMiFvBNJOTP6825/giphy.webp"
		/>
	</Slide>

	<!-- 99 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXdxdGs5bm9qNDl3Z3NzMTlwc2I4dGRlZ2x1cmx2MjNiOTE2ZjU1eCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l2JHVUriDGEtWOx0c/giphy.webp"
			class="h-fit w-[70vw]"
		/>
	</Slide>

	<!-- 100 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExajAzbDJuZGRrbGtldnQ5NDZrbm9mbTY1aXhjZHRieXRpN3U4cmg1OSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xUPGcjKy4Agbb6d928/giphy.webp"
		/>
	</Slide>

	<!-- 101 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcm93cDhodmJ1bzVrbnhmMjk2YzFtOWhqc3VtYmdwdmd3aHN6Y3BiMyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/vNr3DRaqTZ6mWYfXv0/giphy.webp"
		/>
	</Slide>

	<!-- 102 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExNzVrM21iazA0ODJlMGRtMWthcHR5ZXZ2dDg5enB6M3l2am42NGJ1aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/XkDyB1jCZMxUs/giphy.webp"
		/>
	</Slide>

	<!-- 103 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeTQ2cHE5MGpoOHIwcmN6OWxhdWFlcmptMDgwdmFoZzJnMnExYnJjbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/UevalSWg5twQeqpc8Q/giphy.webp"
		/>
	</Slide>

	<!-- 104 -->
	<Slide class="h-full place-content-center place-items-center">
		<p>Skillshare logo</p>
	</Slide>

	<!-- 105 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
