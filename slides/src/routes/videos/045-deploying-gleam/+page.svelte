<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Lottie from '$lib/lottie.svelte'
	import server_animation from '$lib/animations/server-rack.json'
	import house_animation from '$lib/animations/house.json'
	import home_office_animation from '$lib/animations/home-office.json'
	import travel_destination_animation from '$lib/animations/travel-destination.json'
	import update_animation from '$lib/animations/update.json'
	import api_animation from '$lib/animations/api.json'
	import login_animation from '$lib/animations/login.json'
	import html_animation from '$lib/animations/html.json'
	import copy_animation from '$lib/animations/copy.json'
	import { tween, all } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import PageSpeed from '$lib/page-speed.svelte'
	import Img from '$lib/img.svelte'

	let slide_4_class = $state('grid-cols-1 [&>*]:col-start-1 [&>*]:row-start-1')
	let slide_8_show_numbers = $state(false)
	let slide_12_code_el: Code
	let slide_14_code_el: Code
	let slide_23_code_el: Code
	let slide_30_class = $state('gap-8')
	let slide_34_js_class = $state('')
	let slide_37_code_el: Code
	let slide_52_code_el: Code
	let slide_54_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="fler-row flex w-full items-center justify-between gap-32">
			<Transition visible>
				<img
					src="https://media.tenor.com/tDau9a7i5hwAAAAi/alert-siren.gif"
					alt=""
					class="w-[180px]"
				/>
			</Transition>

			<Transition>
				<Img src="https://media1.tenor.com/m/dIYElE0kJHQAAAAd/wee-ship.gif" />
			</Transition>
		</div>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media.tenor.com/0sxUyz6Vt3MAAAAi/clock-joypixels.gif"
			class="w-[32rem]"
			alt=""
		/>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="https://media1.tenor.com/m/hxzwphaULpoAAAAC/upgrades-robots.gif" class="w-[48rem]" />
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid h-full w-full place-items-center gap-32 {slide_4_class}">
			<Transition visible>
				<img src="/logos/lucy/gleam-lucy-glow.svg" alt="" class="w-[16rem]" />
			</Transition>

			<Transition visible>
				<img src="/logos/lucy/gleam-lucy-happy.svg" alt="" class="w-[32rem] -rotate-10" />
			</Transition>

			<Transition visible>
				<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[48rem] -rotate-10" />
			</Transition>
		</div>

		<Transition do={() => (slide_4_class = 'grid-cols-[auto_auto_auto]')} />
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid h-96 w-full grid-cols-3 place-items-center gap-32">
			<Transition>
				<Lottie animation={home_office_animation} class="h-96" />
			</Transition>

			<Transition>
				<Lottie animation={server_animation} class="h-96" />
			</Transition>

			<Transition>
				<Lottie animation={travel_destination_animation} class="h-96" />
			</Transition>
		</div>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExcjN5dmFjeTR6aDZkdWhiYXdkN3dnZ2M2aGRoZTIwbzlqZ3FrM3BraCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/oF5oUYTOhvFnO/200.webp"
			class="w-[32rem]"
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/JG9-sqzIMgQAAAAd/work-files-filing-cabinet.gif"
			class="w-[32rem]"
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<Transition visible>
					<img src="/logos/erlang-white.png" alt="" class="h-[32rem]" />
				</Transition>
				{#if slide_8_show_numbers}
					<Transition visible>
						<p class="text-4xl font-bold">170k packages</p>
					</Transition>
				{/if}
			</div>

			<div class="flex flex-col gap-8">
				<Transition visible>
					<img src="/logos/javascript.png" alt="" class="h-[32rem]" />
				</Transition>
				{#if slide_8_show_numbers}
					<Transition visible>
						<p class="text-4xl font-bold">&gt;3m packages</p>
					</Transition>
				{/if}
			</div>
		</div>

		<Transition do={() => (slide_8_show_numbers = true)} />
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code lang="bash" class="w-fit !text-4xl" theme="catppuccin-mocha" code="gleam build" />
		</div>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Transition visible>
				<div class="w-fit">
					<Code
						lang="bash"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code="gleam build --target javascript"
					/>
				</div>
			</Transition>

			<Transition>
				<div class="w-full">
					<Code
						lang="toml"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`
name = "primes"
version = "1.0.0"
target = "javascript"
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
				bind:this={slide_12_code_el}
				lang="text"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
primes/
└── build/
    └── dev/
        └── javascript
    			`.trim()}
			/>
		</div>

		<Action
			do={async () => {
				await slide_12_code_el!.update`primes/
└── build/
    └── dev/
        └── javascript/
            ├── gleam_stdlib
            ├── primes/
            │   ├── gleam.mjs
            │   └── primes.mjs
            └── prelude.mjs`
			}}
		/>

		<Action
			do={async () => {
				await slide_12_code_el!.selectLines`6-8`
			}}
		/>

		<Action
			do={async () => {
				await slide_12_code_el!.selectLines`8`
			}}
		/>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<div class="w-fit">
				<Code
					lang="bash"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code="gleam build --target erlang"
				/>
			</div>

			<div class="w-full">
				<Code
					lang="toml"
					class="w-full !text-4xl"
					theme="catppuccin-mocha"
					code={`
name = "primes"
version = "1.0.0"
target = "erlang"
					`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				bind:this={slide_14_code_el}
				lang="text"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
primes/
└── build/
    └── dev/
        └── erlang/
            ├── gleam_stdlib
            └── primes/
                └── ebin/
                    ├── primes.beam
                    └── primes@@main.beam
            `.trim()}
			/>
		</div>

		<Action
			do={async () => {
				await slide_14_code_el!.selectLines`7-9`
			}}
		/>

		<Action
			do={async () => {
				await slide_14_code_el!.selectLines`8-9`
			}}
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWtjdGtkaTR6emtwZ2hmeHplbnAyc3A5NWhqN3FicHpsajJ5OW11cyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1X7lCRp8iE0yrdZvwd/giphy.webp"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code lang="bash" class="w-fit !text-4xl" theme="catppuccin-mocha" code="gleam run" />
		</div>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/lXHhSXXL4zkAAAAC/apartando-a-briga-ice-bear.gif"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/javascript.png" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="cp -r build/dev/javascript ~/apps/primes"
			/>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Transition visible>
				<div class="w-fit">
					<Code
						lang="javascript"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`import { main } from "./primes.mjs";
main();`}
					/>
				</div>
			</Transition>

			<Transition>
				<div class="w-full">
					<Code
						lang="bash"
						class="w-full !text-4xl"
						theme="catppuccin-mocha"
						code={`echo 'main()' >> primes.mjs
node primes.mjs`}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExczJyZThzamU0cnE4azVnbXU1cDRrdHgzdWtrcThhaWw2Z3lhc3ZlMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/tIeCLkB8geYtW/giphy.webp"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/erlang-white.png" alt="" class="w-[32rem]" />
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`erl -pa build/dev/erlang/*/ebin \\
  -eval 'primes@@main:run(primes)' -noshell`}
				bind:this={slide_23_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_23_code_el!.selectToken`build/dev/erlang/ * /ebin`
			}}
		/>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/wz_469d_locAAAAC/carrying-boxes-viralhog.gif"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="text"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`erlang-shipment/
├── gleam_stdlib/
├── primes/
└── entrypoint.sh`}
			/>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="gleam export erlang-shipment"
			/>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="cp -r build/erlang-shipment ~/apps/primes"
			/>
		</div>
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/hfv7ST5rSS8AAAAC/perfect-setup-eric-cartman.gif"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbTlsNHNpOHgxdHY1bGlvNGsxb3EwZ2N3d24xNnpxeDd3ZWxmaHE4cSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JIX9t2j0ZTN9S/giphy.webp"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="items_center flex flex-row {slide_30_class}">
			<Transition visible>
				<Lottie animation={house_animation} class="h-64" options={{ loop: false }} />
			</Transition>

			<Transition visible>
				<img src="/logos/lucy/gleam-lucy-happy.svg" alt="" class="w-64 -rotate-10" />
			</Transition>
		</div>

		<Transition
			do={() => {
				slide_30_class = 'gap-[32rem]'
			}}
		/>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/uDgrVufjT78AAAAC/sparks-electrical-electricity-equipment-radio-amateur-fire.gif"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex w-screen flex-col gap-16">
			<Transition visible>
				<h1 class="text-6xl font-bold">FTP/SCP</h1>
			</Transition>

			<Transition>
				<h1 class="text-6xl font-bold">S3</h1>
			</Transition>

			<Transition>
				<h1 class="font-mono text-6xl font-bold">git clone</h1>
			</Transition>
		</div>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/logos/docker-wordmark.svg" class="w-[64rem]" />
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<div class="flex flex-col gap-8">
				<img src="/logos/erlang-white.png" alt="" class="h-[32rem]" />
			</div>

			<div class="flex flex-col gap-8">
				<img
					src="/logos/javascript.png"
					alt=""
					class="h-[32rem] transition-opacity duration-500 ease-in-out {slide_34_js_class}"
				/>
			</div>
		</div>

		<Action
			do={() => {
				slide_34_js_class = 'opacity-30'
			}}
		/>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
		<flex class="flex flex-col gap-8">
			<h1 class="font-mono text-6xl">gleam-lang/gleam</h1>
			<h1 class="font-mono text-6xl">isaacharrisholt/youtube</h1>
		</flex>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="rounded-full bg-red-600 py-6 px-12 text-6xl font-bold text-white shadow-xl">
			Subscribe
		</div>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="dockerfile"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
FROM ghcr.io/gleam-lang/gleam:v1.4.1-erlang-alpine

WORKDIR /build

COPY . /build

# Compile the project
RUN cd /build \\
  && gleam export erlang-shipment \\
  && mv build/erlang-shipment /app \\
  && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
				`.trim()}
				bind:this={slide_37_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`1`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`5`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`3`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`9`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`10`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`11`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.selectLines`15-16`
			}}
		/>

		<Action
			do={async () => {
				await slide_37_code_el!.update`FROM ghcr.io/gleam-lang/gleam:v1.4.1-erlang-alpine

WORKDIR /build

COPY . /build

# Compile the project
RUN cd /build \\
  && gleam export erlang-shipment \\
  && mv build/erlang-shipment /app \\
  && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["shell"]`
			}}
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={server_animation} class="h-96" />
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGc2MXUxazlxdTlrcjM2aGM0NXo5bTVyZ2MxMnowNnR2ZHI2eHNvOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/qbd9gWm8MxlG8/200w.webp"
			class="w-[32rem]"
		/>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-7xl underline">ihh.dev/zima</h1>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={server_animation} class="h-96" />
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<Transition>
				<Img src="/logos/aws-ecr.png" class="h-[16rem]" />
			</Transition>

			<Transition>
				<div class="w-fit">
					<Code
						lang="bash"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`$DOCKER_HOST="" docker compose ...`}
					/>
				</div>
			</Transition>
		</div>

		<Transition>
			<img src="/logos/coolify.svg" class="h-[32rem]" alt="" />
		</Transition>
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/screenshots/coolify-homepage.png" class="mb-8 w-[60vw]" />
		<h1 class="font-mono text-6xl underline">coolify.io</h1>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/screenshots/coolify-config.png" class="w-[60vw]" />
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash"
			/>
		</div>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={travel_destination_animation} class="h-[72rem]" />
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="https://media1.tenor.com/m/SCa_NReG5iEAAAAC/thumbs-up-baby.gif" class="w-[32rem]" />
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/fly-io-white.svg" alt="" class="w-[48rem]" />
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Transition visible>
				<Lottie animation={login_animation} class="h-96" />
			</Transition>

			<Transition>
				<div class="mx-auto w-fit">
					<Code
						lang="bash"
						class="w-fit !text-7xl"
						theme="catppuccin-mocha"
						code="fly auth login"
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGdhZWNhdWllb28yczVsb2syM2lnOWFlb3oyMTRjcG4zeHE0MmRsbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/2D8g2rXcWx1DO/giphy.webp"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				bind:this={slide_52_code_el}
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="fly launch"
			/>
		</div>

		<Action
			do={async () => {
				await slide_52_code_el!.update`fly launch --dockerfile erlang.Dockerfile`
			}}
		/>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/screenshots/fly-launch.png" class="w-[60vw]" />
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				bind:this={slide_54_code_el}
				lang="bash"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code="fly scale count X --region REGION"
			/>
		</div>

		<Action
			do={async () => {
				await slide_54_code_el!.update`fly scale count 1 --region lax`
			}}
		/>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/screenshots/fly-prime-logs.png" class="w-[60vw]" />
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={travel_destination_animation} class="h-[72rem]" />
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHdvcGYxMmgyaDhqejRxN2s2NWgyaHQ5YjF1aHZrd2EybHJ5djVldyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKEdVH8csXxKDO8/giphy.webp"
			class="h-[32rem]"
		/>
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-7xl underline">ihh.dev/zima</h1>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
