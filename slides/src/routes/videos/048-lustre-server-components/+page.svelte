<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import message_animation from '$lib/animations/message.json'
	import actor_animation from '$lib/animations/actor.json'
	import realtime_app_animation from '$lib/animations/realtime-app.json'
	import uber_animation from '$lib/animations/uber.json'
	import cube_animation from '$lib/animations/cube.json'
	import server_rack_animation from '$lib/animations/server-rack.json'
	import ping_animation from '$lib/animations/ping.json'
	import website_render_animation from '$lib/animations/website-render.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'

	const SLIDE_16_DEFAULTS = {
		lucy_layout:
			'grid grid-cols-1 grid-rows-1 place-items-center [&>*]:col-start-1 [&>*]:row-start-1',
		lucy_size: 360,
		servers_visible: false,
	}
	let slide_16 = $state({ ...SLIDE_16_DEFAULTS })

	let slide_22_ping_visible = $state(false)

	let slide_38_code_el: Code

	let slide_49_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExemU4dnRvNWuseGlhNTQxZ3J5ZDJod2JocDE4eng0b3MzbmpyMnI1bSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cMNJ5t5HrnWMpwe5Zt/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={realtime_app_animation} class="h-[70vh]" />
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExaHI3dmFleGk3ZGd3cWMxNXQ4c3dsb2l3dmxuZHNmOXQzc3lieTBwOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/QOWXNdOXO7mj3LVbLs/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={uber_animation} class="h-[70vh]" />
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<p>Zed video</p>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExOGk3NzAyMDZvY3FrNDduaXg2dm12M25vejUyMXJwMDltM3czNnp6aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/d3YQCPcckxQiYibe/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbm4wa2ZwY2M2ZGNvenVtMWJpODd4cXg5cHBmZzRnNHEwMWpubzlzaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1hTQIgyY5sk3IGKRWu/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.tenor.com/m/7imovmmNqoYAAAAd/data-center-security-market.gif"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExazRxbWMwbTd1ZmhlZ3RtdzFjMHBud2F5djh4dTV2eWRwY3MwdnM4aSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o6wrEBFy8xNknJNgk/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex items-center gap-48">
			<Transition visible>
				<img src="/logos/lucy/gleam-lucy.svg" alt="" class="w-[32rem] -rotate-10" />
			</Transition>

			<Transition>
				<h1 class="text-9xl font-bold">Lustre</h1>
			</Transition>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Server Components</h1>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbGw3eDFkNm1yY210c2xmd29raWNpZzFnbTRuY3BvcXczMDlvbW04YSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KwonkdizuYjHV1oGJy/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExOWlxcHc3eG53OW96cGtyaGp4dTBjZm9mNDBuaTNmang4bWczcWdndiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/tkApIfibjeWt1ufWwj/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExNW16ZHhsdmZjNGtpazdoMXNpMHRyZ3E5ZDZxeG1vazBrazRrMGl1YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/26tn33aiTi1jkl6H6/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXd2bGFpaWJkaXp3emVlNGI1cGc1NmRmM3d2MmloeG5zNmJmZ21ldyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xULW8MYvpNOfMXfDH2/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 16 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_16 = { ...SLIDE_16_DEFAULTS }
		}}
	>
		<Transition visible>
			<div class={slide_16.lucy_layout}>
				{#each [1, 2, 3, 4, 5] as i (i)}
					<Transition visible>
						<img
							src="/logos/lucy/gleam-lucy.svg"
							alt=""
							class="-rotate-10"
							style:width="{slide_16.lucy_size}px"
						/>
					</Transition>
				{/each}

				{#if slide_16.servers_visible}
					{#each [1, 2, 3, 4, 5] as i (i)}
						<Transition visible>
							<div style:width="{slide_16.lucy_size}px">
								<Lottie animation={server_rack_animation} class="w-full" />
							</div>
						</Transition>
					{/each}
				{/if}
			</div>
		</Transition>

		<Transition
			do={() => {
				slide_16.lucy_layout = 'grid grid-cols-5 gap-x-16 gap-y-4 place-items-center'
				slide_16.lucy_size = 100
				slide_16.servers_visible = true
			}}
		/>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex items-center gap-24">
			<Img src="/thumbnails/040.png" class="h-[40vh]" />
			<Img src="/thumbnails/044.png" class="h-[40vh]" />
		</div>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGw5cDlyaml0aDdjN3h1NWZyaWxvZGpleGM4OXZkejZpZGg3eGo0ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WoWm8YzFQJg5i/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/the-elm-architecture.png" alt="" class="w-[60vw]" />
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<Stack>
			{#if slide_22_ping_visible}
				<Lottie animation={ping_animation} class="h-[70vh] opacity-70" />
			{/if}
			<Lottie animation={cube_animation} class="h-[70vh]" />
		</Stack>

		<Action
			do={() => {
				slide_22_ping_visible = true
			}}
		/>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbzBrNzhxa3BuOW5vamRiYXl4ZHYwZjZ4YmJlMTJiYmh4b3N2MHhzdyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8vOEIc1tadLs25Ext5/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={website_render_animation} class="h-[70vh]" />
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="html"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
<script type="application/json" id="model">
	{
		"current_pokemon": "zorua"
	}
</script>
						`.trim()}
			/>
		</div>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/the-elm-architecture.png" alt="" class="w-[60vw]" />
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/lustre-server-components.png" alt="" class="w-[90vw]" />
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="js"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code="const webSocket = new WebSocket('wss://localhost:8000/pokemon-list')"
			/>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExazN4eXpxY2VncjRjdmdlYWRmdGJ6MjRwajk0ZHp0MjhvcXp1bDhydCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/hICcvNYh7VQjiCq8dC/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Setup Options</h1>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/lustre-server-components-per-user.png" alt="" class="w-[90vw]" />
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/lustre-server-components-shared.png" alt="" class="h-[90vh]" />
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/lustre-server-components-groups.png" alt="" class="h-[90vh]" />
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeDJlODI0bTQyczFxczQ3eGFwNnZ4bGJoZjl5djg5ZDU1ZWNwcWo3dyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ua7vVw9awZKWwLSYpW/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMjFoaXkwazNsazV2djY0c2N0dnhtN2F5Z2VjZjMyejE1cXR0aWVtbCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0Ex6kAKAoFRsFh6M/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Img src="/screenshots/codecrafters-sponsor-page.png" class="h-[70vh] w-fit" />
			<p class="font-mono text-7xl font-bold underline">ihh.dev/codecrafters</p>
		</div>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Img src="/screenshots/lustre-server-component-demo.png" class="h-[70vh] w-fit" />
			<p class="font-mono text-4xl font-bold underline">
				github.com/lustre-labs/lustre/tree/main/examples/99-server-components
			</p>
		</div>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExcnh1dGhqZmdzMTB3OW5obDlocmZlNW1sNGR2OW05Y243dWt6b2E0NSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/DDs5uoV0YrvoSdl04L/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdWNwZGIwaTFsYW96bDZ1dHdmN3ZmeHZ1aXFkamFvYzk1MzVubHY5cyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/36EYJaR1Encg8/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				bind:this={slide_38_code_el}
				code={`
fn view(model: Model) -> Element(Msg) {
  let styles = [#("width", "100vw"), #("height", "100vh"), #("padding", "1rem")]
  let count = int.to_string(model)

  ui.centre(
    [attribute.style(styles)],
    ui.stack([], [
      ui.button([event.on_click(Incr)], [element.text("+")]),
      html.slot([]),
      html.p([attribute.style([#("text-align", "center")])], [
        element.text(count),
      ]),
      ui.button([event.on_click(Decr)], [element.text("-")]),
    ]),
  )
}
				`.trim()}
			/>

			<Action
				do={async () => {
					await slide_38_code_el!.selectLines`9`
				}}
			/>
		</div>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="html"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
<lustre-server-component>
  <slot />
</lustre-server-component>
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/thumbnails/040.png" class="h-[70vh]" />
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible>
				<Lottie animation={actor_animation} class="h-[35vh]" />
			</Transition>

			<Transition>
				<Img
					src="https://i.etsystatic.com/11441782/r/il/df8569/4027163603/il_fullxfull.4027163603_lj7p.jpg"
					class="w-[20vw]"
				/>
			</Transition>
		</div>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHc4eXhtam45cHNiNzJrZXpmMnY0bnExbjI5ZzlpbHFqNWVlamh4eSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8dYmJ6Buo3lYY/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/diagrams/lustre-server-components.png" alt="" class="w-[90vw]" />
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
		<h1 class="font-mono text-6xl">isaacharrisholt/youtube</h1>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExN29zMDFxZWZpZ3RwdDNseHMyMnY5bnMxaXJ0ZGx4OWUzZDhsa2p2OCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/dVdIu1HNxeKyqzkgPA/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjR4YjFzY3FhcXlkb2htbmI0b3ZlN2hrc3JmaXI0NGtrYXl1YTYzbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/nZZmhLoZkDSTfYQqEw/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
you()
|> subscribe
|> like
|> comment
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbzJobTZzcGtwZWkxeXo5eTN5dWhzNGw5czFucDgxZ3Y2M3pnYTZyMiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/2oUfvvUgQHnLsQWFMW/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				bind:this={slide_49_code_el}
				code="server_component.subscribe(???)"
			/>
		</div>

		<Action
			do={async () => {
				await slide_49_code_el!.update`server_component.subscribe(id)`
			}}
		/>

		<Action
			do={async () => {
				await slide_49_code_el!.update`server_component.subscribe("ws")`
			}}
		/>
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdmlkcmYwczVmNmd0ZXI5cDY3a2MwZHA3M3VvdnI2eTRrem45bm1lZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/tOBFj21UvNBN81NIug/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmRldTNjeDhqbXgxbWpzbXp6cDF4enFzZW5yaTlleHI4bGEzOWN0MyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/tGiJyldyNUJXO/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://i.guim.co.uk/img/media/44856f0611a6ae5e8f4e1875772d8f462a7e6f10/0_139_1118_671/master/1118.jpg?width=700&quality=85&auto=format&fit=max&s=3be77831a235ffc09d12cf9d18be5f25"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="html"
				class="w-fit !text-4xl !leading-tight"
				theme="catppuccin-mocha"
				code={`
<button onclick="send_message()">
	Send Message
</button>
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExb3U3emg4NHJ0cmt1cWM0aTd5dzZxOThiYXJyOTlkNjZub2JycG5sNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xoHntNXFYkfzGAftEv/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={realtime_app_animation} class="h-[70vh]" />
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTZlNjBzemwxZnJtaXVwdjEzcWM3cXpiM2s0anEzcXN5MXcxcngzOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/htFUXJH5vjgIw/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMzk0ZGY1ZG1kM3B3N2lyZ2Jkbmt5b3NyZXBxdTFsOW5ld3BibTU5biZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ZBQhoZC0nqknSviPqT/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="/screenshots/phoenix-liveview-github.png"
			alt=""
			class="mb-12 w-[50vw] rounded-xl shadow-xl"
		/>
		<h1 class="font-mono text-6xl">phoenixframework/phoenix_live_view</h1>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDUzZjF5a3R6cW8wYjRuMmVnamFkaXRoN3hlM2xsZmx2NnZ4MmFnciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l2JHVUriDGEtWOx0c/giphy.webp"
			class="w-[70vw]"
		/>
	</Slide>

	<!-- 60 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl font-bold">Server <span class="underline">Components</span></h1>
	</Slide>

	<!-- 61 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeXF4cGV1ZTN6cDQ2cnprZmpzamFkYjk4bmpqdnFmNHJrbGdvM3pxdSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WgRybKqrkzuxm2KXnY/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 62 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Img src="/screenshots/codecrafters-sponsor-page.png" class="h-[70vh] w-fit" />
			<p class="font-mono text-7xl font-bold underline">ihh.dev/codecrafters</p>
		</div>
	</Slide>

	<!-- 63 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
