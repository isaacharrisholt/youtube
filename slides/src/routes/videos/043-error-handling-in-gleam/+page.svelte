<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'

	const SLIDE_2_DEFAULTS = {
		logo_1_visible: false,
		logo_3_visible: false,
	}
	let slide_2 = $state({ ...SLIDE_2_DEFAULTS })

	const SLIDE_9_DEFAULTS = {
		lucy_layout:
			'grid grid-cols-1 grid-rows-1 place-items-center [&>*]:col-start-1 [&>*]:row-start-1',
		lucy_size: 360,
		servers_visible: false,
	}
	let slide_9 = $state({ ...SLIDE_9_DEFAULTS })

	const SLIDE_23_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_23 = $state({ ...SLIDE_23_DEFAULTS })

	const SLIDE_24_DEFAULTS = {
		code_el: undefined as Code | undefined,
		code: `
let fibs = [1, 1, 2, 3, 5, 8, 13]

case fibs {
  [one, _, two, ..rest] -> do_something()
  _ -> panic as "Invalid fibs!"
}
		`.trim(),
	}
	let slide_24 = $state({ ...SLIDE_24_DEFAULTS })

	const SLIDE_27_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_27 = $state({ ...SLIDE_27_DEFAULTS })

	const SLIDE_28_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_28 = $state({ ...SLIDE_28_DEFAULTS })

	const SLIDE_46_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_46 = $state({ ...SLIDE_46_DEFAULTS })

	const SLIDE_55_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_55 = $state({ ...SLIDE_55_DEFAULTS })

	const SLIDE_56_DEFAULTS = {
		code_el: undefined as Code | undefined,
	}
	let slide_56 = $state({ ...SLIDE_56_DEFAULTS })
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdXpwcDF5Nm94dGFxbXp0MGExa3p0cXM5Y2oycHI0ZHBxODc0Z2Z6eSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/mguPrVJAnEHIY/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 2 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_2 = { ...SLIDE_2_DEFAULTS }
		}}
	>
		<div class="grid grid-cols-3 place-items-center gap-12">
			<div>
				{#if slide_2.logo_1_visible}
					<img class="w-52" src="/logos/sentry-white.png" alt="" />
				{/if}
			</div>

			<img class="w-52" src="/logos/sentry-white.png" alt="" />

			{#if slide_2.logo_3_visible}
				<img class="w-52" src="/logos/sentry-white.png" alt="" />
			{/if}

			<Action
				do={() => {
					slide_2.logo_1_visible = true
				}}
			/>
			<Action
				do={() => {
					slide_2.logo_3_visible = true
				}}
			/>
		</div>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeXpmbTg2cWlhMGJ6cndjam9jNWxpeG1xMWZvdXY5YXl4d3MydnFwcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KbeMMTRmTCF11CPLq1/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXo5NmZ4Mnh2eTVqdThnMDk0OTh4NmV6aWF1dXJtdm9lOXp3eDhpZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/26n6WywJyh39n1pBu/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExN3hpb3NiN3Nkb2Jha3Jka2M2c2wzM2MyN2c0dHB1dWJlaHZzMzB5YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8cVraaL8lrUg8/200w.webp"
			alt=""
		/>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjZzeXliZG5lMHZxcjV6Z3RiNm96aDl2ajhvb2RmajE1aXRwbno0bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/wID3zXURLH1jrjCcZy/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWY0cm14a3pvcGNuNGxkYjB0MzdpNnFiZ3hsNGNwZmFpM3ZlbnhpeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BasedgNjmxXws/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-2 place-items-center gap-8">
			<div class="w-fit">
				<Code
					lang="rust"
					theme="catppuccin-mocha"
					class="w-fit"
					code={`
let ok_value = some_erroring_function()?;
`.trim()}
				/>
			</div>

			<div class="w-fit">
				<Code
					lang="go"
					class="w-fit"
					theme="catppuccin-mocha"
					code={`
err := someErroringFunction()
if err != nil {
	return err
}
`.trim()}
				/>
			</div>

			<div class="w-fit">
				<Code
					lang="elixir"
					class="w-fit"
					theme="catppuccin-mocha"
					code={`
result = some_erroring_function()
case result do
  {:ok, value} ->
    value
  {:error, error} ->
    raise error
end
`.trim()}
				/>
			</div>

			<div class="w-fit">
				<Code
					lang="zig"
					class="w-fit"
					theme="catppuccin-mocha"
					code={`
some_erroring_function() catch |err| {
	return err;
}
`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 9 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_9 = { ...SLIDE_9_DEFAULTS }
		}}
	>
		<Transition visible>
			<div class={slide_9.lucy_layout}>
				{#each [1, 2, 3, 4, 5] as i (i)}
					<Transition visible>
						<img
							src="/logos/lucy/gleam-lucy.svg"
							alt=""
							class="-rotate-10"
							style:width="{slide_9.lucy_size}px"
						/>
					</Transition>
				{/each}

				{#if slide_9.servers_visible}
					{#each [1, 2, 3, 4, 5] as i (i)}
						<Transition visible>
							<img src="/icons/server.gif" alt="" style:width="{slide_9.lucy_size}px" />
						</Transition>
					{/each}
				{/if}
			</div>
		</Transition>

		<Transition
			do={() => {
				slide_9.lucy_layout = 'grid grid-cols-5 gap-x-16 gap-y-4 place-items-center'
				slide_9.lucy_size = 100
				slide_9.servers_visible = true
			}}
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-20">
			<Transition visible>
				<img src="/logos/erlang-white.png" alt="" class="h-52" />
			</Transition>

			<Transition>
				<img src="/logos/javascript.png" alt="" class="h-52" />
			</Transition>
		</div>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="relative">
			<img
				src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcHJ3ZXJhOGxseHpxZ3AyaTlta3ZvM29lZ3BiYXNhZHVmcmFqd2M5ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/KrmfpsbTd1YgfCR6aN/giphy.webp"
				alt=""
			/>

			<img
				src="/logos/lucy/gleam-lucy-happy.svg"
				alt=""
				width="100rem"
				class="absolute top-[2.5rem] left-[8rem] -rotate-10"
			/>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGJpbXVxajM4NXlrb3JjMjduMHFkYmhldDQ4dTZodDg3cm1jZHVmdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/YSOXoZlrRm5is6L2Rd/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExMm5icnJtdmZsNmJqaHIyY3ljdW41MzZ6emQ2ZTV0eHB3MDJhZ2EzbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/FjOsaw9z4BhrW/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdDBvZGg1Z3dmdjkzZjV5b2NhMW5vYmpvZGplbTZ2Z2VwcnFuNmR1MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/MtIPR6C5okdt6/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/erlang-white.png" alt="" height="50%" />
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZXg0eTY1Nnl2Z25jcW5nejExOHF4N3Y3bjV6dWF6NTI1ZDBicjFqdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/seUvFGNK0cQJG/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcWl4ZmVvc3FzN2ltdzV3YWJycXFrYzczdXd5dmkyYWVhdWZjYnJ1ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/w8xvymsStCpQA/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="relative">
			<img src="/diagrams/erlang-supervision-tree.png" alt="" width="600rem" />

			<img
				src="https://media.tenor.com/EdE42jqp1OoAAAAi/tijka-tijka-button.gif"
				alt=""
				class="absolute -right-4 -bottom-4"
			/>
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center gap-4">
		<img src="/thumbnails/040.png" alt="" class="w-[60%] shadow-xl" />
		<h3>The Ultimate Guide to Gleam Concurrency</h3>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZnF1eDFqdXlhdjg5cHp3Nnp0ZjR5eDdvM2R0Y2pobHdlMDIzczlwMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ftAyb0CG1FNAIZt4SO/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXEzNmdtbXNqNjRuZWFueDV2dzk0ejd5OWEweGNub2ZoNWQxbjVyNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jl4lADw1X7fjI7MjuX/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/lucy/gleam-lucy-happy.svg" alt="" class="-rotate-10" width="100%" />
	</Slide>

	<!-- 23 -->
	<Slide
		class="h-full place-content-center place-items-center gap-8"
		out={() => {
			slide_23.code_el!.selectLines`*`
		}}
	>
		<Transition visible>
			<div class="w-[80vw]">
				<Code
					lang="gleam"
					class="h-fit"
					theme="catppuccin-mocha"
					code={`
panic as "I have decided to manually panic"
todo as "I'm not sure what to do here"
`.trim()}
					bind:this={slide_23.code_el}
				/>
			</div>
		</Transition>

		<Action
			do={async () => {
				await slide_23.code_el!.selectLines`1`
			}}
		/>
		<Action
			do={async () => {
				await slide_23.code_el!.selectLines`2`
			}}
		/>
		<Action
			do={() => {
				slide_23.code_el!.selectLines`*`
			}}
		/>

		<Transition>
			<div class="w-fit">
				<Code
					lang="text"
					class="h-fit"
					theme="catppuccin-mocha"
					code="Error: I have decided to manually panic"
				/>
			</div>
		</Transition>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="rust"
				class="w-fit"
				theme="catppuccin-mocha"
				code={slide_24.code}
				bind:this={slide_24.code_el}
				options={{ enhanceMatching: true }}
			/>
		</div>

		<Action
			do={async () => {
				await slide_24.code_el!.update`let fibs = [1, 1, 2, 3, 5, 8, 13]

let assert [one, _, two, ..rest] = fibs`
			}}
		/>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExczJyejFlZGc3bGNkc3l4bDg4dTRpdmpxZzRiM2hqODdlcWt5dGR5ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0IxYWDltdHEqujnO/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcXppOTc2cW43ZTI2bDA3aG90azBhcm82cTdhcmZ2b2xsemNiczlxcyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/5Qbi5JEiCWyTYYtpd4/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 27 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_27.code_el!.selectLines`*`
		}}
	>
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
type Result(t, e) {
  Ok(t)
  Error(e)
}
`.trim()}
				bind:this={slide_27.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_27.code_el!.selectLines`2`
			}}
		/>
		<Action
			do={async () => {
				await slide_27.code_el!.selectLines`3`
			}}
		/>
	</Slide>

	<!-- 28 -->
	<Slide
		class="h-full place-content-center place-items-center"
		out={() => {
			slide_28.code_el!.selectLines`*`
		}}
	>
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
fn get_price(item: String) -> Result(Float, String) {
  case item {
    "time" -> Error("item is priceless")
    _ -> Ok(19.99)
  }
}
`.trim()}
				bind:this={slide_28.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_28.code_el!.selectLines`3-4`
			}}
		/>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExOXduamN4M20yeWNhdWpza2YyOWk5dGRkNTBsa3Q4Mmtnd2YxZjdocyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LxVZYtJmKiDw8Trd8h/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXZqNTdyZzdra2w4MGU0YmZ4N3I2NzEzcTNnbGxtbHZ3YXl6a3YxbSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gEvab1ilmJjA82FaSV/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcGN2YXlzdnMxcDBmeDk4eTRzbWVpdDN4NXk2Zmx4djMwNTFjZ3ZsZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/wRgtUUCRA8uQ42TnxS/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<Transition visible>
			<div class="w-fit">
				<Code lang="gleam" class="w-fit" theme="catppuccin-mocha" code="fn() -> Result(a, b)" />
			</div>
		</Transition>

		<Transition>
			<div class="relative">
				<div class="w-fit">
					<Code
						lang="javascript"
						class="w-fit"
						theme="catppuccin-mocha"
						code={`
try {
  ruinEverything()
} catch (error) {
  someReallyBadErrorHandler(error)
}
					`.trim()}
					/>
				</div>

				<img
					src="https://media.tenor.com/xbTXLx593n8AAAAi/ami-fat-cat-yuck.gif"
					alt=""
					class="absolute -right-4 -bottom-4"
				/>
			</div>
		</Transition>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ25vbGg0cHVubzM5bjVhZnV2cGJybXR5Y3EwdGw1dGoyb3d5cWkzYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8tFMtt7HtXtMeveqbO/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<pre class="!bg-transparent !text-4xl">throw ~= goto catch</pre>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="https://media1.tenor.com/m/LV7eIYVhLhQAAAAC/scale-opposites.gif" alt="" />
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<!-- code example to show polluted callstack -->
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
fn wibble() -> Result(a, b)

fn wobble() -> Result(Result(a, b), c)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExbnU3OGJrdjluMjVqMGJvNWR6OWNjaTloaXFtM3Izbm9qazIycGphYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/NdKVEei95yvIY/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code="let assert Ok(❤️) = subscribe(you)"
			/>
		</div>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExNTBrbGkxZ2Z0N2lyM2RiZmxhNzQ1djI5eXc3ZXpwNnh0MDlzeWtmbCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/fqguMaiKr6eLD5OsMP/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="relative">
			<img
				src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExdHZpNmQwYzRycm1xNnZvMG8wenFrMzFrcXJvZHVndzdoODY5c21zdyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/XfQDhhaVjL0wOl9Jkr/giphy.webp"
				alt=""
			/>

			<img
				src="/people/aaron-francis-transparent.png"
				alt=""
				width="40rem"
				class="absolute top-[3.1rem] left-[15.2rem] -rotate-8"
			/>
		</div>
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
let assert Ok(price) = get_price("lambo")

io.println(float.to_string(price))
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmp4dzk1enJkdmNxdGY1Zm1wa204bzl2Y2ZkcnF3ZGVjczcwNXljYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/2Bht4u8WRFJDi/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code="let assert Ok(re) = regex.from_string({`"[0-9]"`})"
			/>
		</div>
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzZ5bW81NGNmYWdrdDBsZmppenlnNWh6bDVzcDZtNzRsNnlxaXZlMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/5xtDarFyiyCe1lH7jYk/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<pre class="!bg-transparent !text-4xl font-bold">Do it yourself!</pre>
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
case get_price(item) {
  Ok(price) -> io.println(float.to_string(price))
  Error(e) -> io.println("Error: " <> e)
}
				`.trim()}
				bind:this={slide_46.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_46.code_el!.selectLines`3`
			}}
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExcTB2cHFuMXI1bDgwOGl0eXExcThleGp3bjcwaDlnZDh6MHlieHFyNiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/a5viI92PAF89q/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmZ6NDh4bjBnMjE1NjVrcG9lM2Zod2dxZ3h1YTE2eTA4YTB0ZjQ0byZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1xVbRS6j52YSzp9P7N/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
fn get_price(item: String) -> Result(Float, String) {
  case item {
    "time" -> Error("item is priceless")
    _ -> Ok(19.99)
  }
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
result.try(get_price("lambo"), fn(price) {
  io.println(float.to_string(price))
  Ok(Nil)
})
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTMwOTZna21ieTRldWljZGhveHkzbzJheHp5NGVocm8zOWowYThjYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/gxhU80is6fOKI/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2hqODdnNzc4M25zbHA2YnpyaWZvZmFxOHMyd29ycTNheGg3azI0MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Lopx9eUi34rbq/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 53 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
result.try(get_price("lambo"), fn(p1) {
  result.try(get_price("mini cooper"), fn(p2) {
    result.try(get_price("ford f150"), fn(p3) {
      Ok(p1 +. p2 +. p3)
    })
  })
})
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 54 -->
	<Slide class="h-full place-content-center place-items-center">
		<pre class="!bg-transparent !text-4xl font-bold">use &lt;-</pre>
	</Slide>

	<!-- 55 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<Transition visible>
			<div class="w-fit">
				<Code
					lang="rust"
					class="w-fit"
					theme="catppuccin-mocha"
					code={`
my_func(args, fn(params) { 
  operations 
})
				`.trim()}
					bind:this={slide_55.code_el}
				/>
			</div>
		</Transition>

		<Action
			do={async () => {
				await slide_55.code_el!.update`use

my_func(args, fn(params) {
  operations
})`
			}}
		/>

		<Action
			do={async () => {
				await slide_55.code_el!.update`use params <-

my_func(args, fn() {
  operations
})`
			}}
		/>

		<Action
			do={async () => {
				await slide_55.code_el!.update`use params <- my_func(args)

fn(params) {
  operations
}`
			}}
		/>

		<Action
			do={async () => {
				await slide_55.code_el!.update`use params <- my_func(args)
operations`
			}}
		/>

		<Transition>
			<div class="w-fit">
				<Code
					lang="rust"
					class="w-fit"
					theme="catppuccin-mocha"
					code={`
		my_func(args, fn(params) {
		  operations
		})
							`.trim()}
				/>
			</div>
		</Transition>
	</Slide>

	<!-- 56 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
result.try(get_price("lambo"), fn(p1) {
  result.try(get_price("mini cooper"), fn(p2) {
    result.try(get_price("ford f150"), fn(p3) {
      Ok(p1 +. p2 +. p3)
    })
  })
})
				`.trim()}
				bind:this={slide_56.code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_56.code_el!.update`use p1 <- result.try(get_price("lambo"))
use p2 <- result.try(get_price("mini cooper"))
use p3 <- result.try(get_price("ford f150"))
Ok(p1 +. p2 +. p3)`
			}}
		/>
	</Slide>

	<!-- 57 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExY3h0OWtsMDk1MnNrN2ZoNm5zNHhkZmUweXh3eXh3aHY5ZmQ5cnNuMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/LTiV0trgr8l54vNRGY/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 58 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExb2R1dDg3azBud29hNDYyNnNpdjYzbm1jcDU5ZG1lbzVlYjBiNXBjOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3ohhwfL19q2eCPaBEs/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 59 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
pub type MyError {
  // ...
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 60 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExdmh6aW5nNmV1MWpjM2FweDR4M3NudGJ2dGo5ZTczdWI1MzZpNjJkZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WoWm8YzFQJg5i/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 61 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExeWFlNzZ4cDZwajNqNXgyNHJldzZoZDdic29heDJ1eDR6cm9pOXVkdyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/I1U9DTjCqOF3i/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 62 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
pub type MyError {
  ConfigReadError(FileError)
  // ...other error variants
}
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 63 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
use config_str <- result.try(
  file.read("./config_file")
  |> result.map_error(ConfigReadError),
)

// We can use \`config_str\` in our code
parse_config(config_str)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 64 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<img src="/screenshots/snag-github.png" alt="" class="w-[720px]" />

		<h2>lpil/snag</h2>
	</Slide>

	<!-- 65 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="gleam"
				class="w-fit"
				theme="catppuccin-mocha"
				code={`
use config_str <- result.try(
  file.read("./config_file")
  |> snag.context("Could not read config file"),
)
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 66 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2dsdHR3NHRoNWswcXNsN2htZzI0bGM4anplc2JlZnVnaTdiM3U5YSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/sVnKj2wDhUTsFKFWhx/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 67 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExdm44MGRnMHR0cTFheG1sNjg2c2Vxb21lYW54a29tcHplOGw3a2R0ZSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/qadvd1vBaZBBu/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 68 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnAwbjk2YTU3cmUxdWV2ZnJydmdqMHpocjh2cXp3aGY0aGlndjJwaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lCrdfgqSt4fhS/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 69 -->
	<Slide class="h-full place-content-center place-items-center">
		<img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExd2F0MzNsY2hoaXphemRsdWJyYm9rNjU5azh4aDM0bWllMXM0MjY3ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JUeMoYHHQCeiI14Zhd/giphy.webp"
			alt=""
		/>
	</Slide>

	<!-- 70 -->
	<Slide class="h-full place-content-center place-items-center" />
</Presentation>
