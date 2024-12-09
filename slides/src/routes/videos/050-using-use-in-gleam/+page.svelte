<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import message_animation from '$lib/animations/message.json'
	import plug_animation from '$lib/animations/plug.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'

	let slide_6_text_blur = $state(true)
	let slide_16_code_el: Code
	let slide_20_code_el: Code
	let slide_21_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/logos/lucy/gleam-lucy.svg" class="h-[32rem] -rotate-10" default />
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeDJhcTJvMHRoZTY3M2RxNWJyeWc5YTl5d2FuaW9nb2k0bDl2Zm5pbyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3oEduSi2isGBb4WFRS/giphy.webp"
		/>
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdWUwcDQxZ3dwMzFuM2c4Nmx6dDlycnlkOTNlNGxkeGc4aXBpd2xwaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/VEVfqy0Vu4c7xziUUN/giphy.webp"
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjBndHB0enF2OXQ2M2d0YnZ0djZ0NXgzOHNhYjlzZDc0OHRhYW1rYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3KEJl20q5ggBW/giphy.webp"
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMXZrZGpsZjFkd2hxcDg5Y3d1NjJxYnVydG1jazYwZXd4ZnM1OHBwaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Rl9Yqavfj2Ula/giphy.webp"
		/>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1
			class="font-mono text-9xl transition-all duration-800 ease-in-out"
			class:blur-xl={slide_6_text_blur}
		>
			use
		</h1>

		<Action
			do={() => {
				slide_6_text_blur = false
			}}
			undo={() => {
				slide_6_text_blur = true
			}}
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExOWhmcmFocHcwcDg4YW9sOXN5aXZleWJ3dWw1MnozbWh5Znlud256cCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0ExhXFQ03zxPu7ew/giphy.webp"
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center gap-6">
		<h1 class="text-9xl">Let's use <span class="font-mono">`use`</span></h1>
		<p>How many times do I say 'use' in this video?</p>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcGMzNThjYnQ1ZTM2NHduM3JnOGZxM2V1YWs1ejNjMW9oYmdrMHYwdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Apfu83XTIdfGtq9QZP/giphy.webp"
		/>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdmRjcDQ1bjUxOTJuNXI0aDB0cTExd3lrM2V4NXk0bTdiOXgyYWcyYyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l0MYryZTmQgvHI5TG/giphy.webp"
		/>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWY0Z3dveDRiZHkybGRtNmdvem81Y2VteG90dTU1c2tkNXVqaW8wbiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Lopx9eUi34rbq/giphy.webp"
		/>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="js"
				theme="catppuccin-mocha"
				code={`
[1, 2, 3, 4, 5].map(
  // This is a callback function
  (n) => {
    return n * n
  }
)
`.trim()}
			/>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="js"
				theme="catppuccin-mocha"
				code={`
fetch('https://pokeapi.co/api/v2/pokemon/zorua').then((response) => {
  return response.json().then((data) => {
    return Promise.all(data.moves.map((move) => {
      return fetch(move.url).then((response) => {
        return response.json().then((data) => {
          return data
        })
      })
    })).then((moves) => {
      return moves
    })
  })
})
    `.trim()}
			/>
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExaGNsYWNxd3hnMWM1MjJrdGZ6YzZpcnFpenAzeWJtNWF5a3Zxc2F1MiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT5LMNr2nowklaKpt6/giphy.webp"
		/>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcDY1ZGNyNGtvczJ0a2s5a3phZG1mdWN4NGxsZ2s2Nzd1bGprOWZoYiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/9wIMQtSaKjoaI/200.webp"
		/>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
fn try(
  result: Result(a, b),
  apply fun: fn(a) -> Result(c, b)
) -> Result(c, b)
`.trim()}
					/>
				</div>
			</Transition>

			<Transition>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						bind:this={slide_16_code_el}
						code={`
try(pokemon.fetch_by_name(client, "zorua")), fn(pokemon) {
  list.map(pokemon.moves, fn(mv) {
    move.fetch_by_resource(mv.move)
  })
})
`.trim()}
					/>
				</div>
			</Transition>
		</div>

		<Action
			do={async () => {
				await slide_16_code_el.update`use pokemon <- try(pokemon.fetch_by_name(client, "zorua"))
list.map(pokemon.moves, fn(mv) {
  move.fetch_by_resource(mv.move)
})`
			}}
			undo={() => {
				slide_16_code_el.update`try(pokemon.fetch_by_name(client, "zorua")), fn(pokemon) {
  list.map(pokemon.moves, fn(mv) {
    move.fetch_by_resource(mv.move)
  })
})`
			}}
		/>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl">defer</h1>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="go"
				theme="catppuccin-mocha"
				code={`
conn := NewDB(connectionString)
defer func() {
	logger.Debug("Closing DB connection")
	conn.Close()
}()

rows, err := conn.Execute("...")
`.trim()}
			/>
		</div>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn defer(cleanup: fn() -> Nil, body: fn() -> a) -> a {
  // Run the body function
  let res = body()
  // Run the cleanup function
  cleanup()
  // Return the result of the body function
  res
}
        `.trim()}
			/>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				bind:this={slide_20_code_el}
				code={`
let db = postgres.connect(config)
defer(
  fn() {
    log.debug("Closing DB connection")
    postgres.close(db)
  },
  fn() {
    postgres.execute(conn, "...")
  },
)
        `.trim()}
			/>
		</div>

		<Action
			do={async () => {
				await slide_20_code_el.update`let db = postgres.connect(config)
use <- defer(fn() {
  log.debug("Closing DB connection")
  postgres.close(db)
})

postgres.execute(conn, "...")`
			}}
			undo={() => {
				slide_20_code_el.update`let db = postgres.connect(config)
defer(
  fn() {
    log.debug("Closing DB connection")
    postgres.close(db)
  },
  fn() {
    postgres.execute(conn, "...")
  },
)`
			}}
		/>

		<Action
			do={async () => {
				await slide_20_code_el.selectLines`7`
			}}
			undo={() => {
				slide_20_code_el.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
my_func(args, fn(params) { 
  operations 
})
				`.trim()}
				bind:this={slide_21_code_el}
			/>
		</div>

		<Action
			do={async () => {
				await slide_21_code_el!.update`use

my_func(args, fn(params) {
  operations
})`
			}}
		/>

		<Action
			do={async () => {
				await slide_21_code_el!.update`use params <-

my_func(args, fn() {
  operations
})`
			}}
		/>

		<Action
			do={async () => {
				await slide_21_code_el!.update`use params <- my_func(args)

fn() {
  operations
}`
			}}
		/>

		<Action
			do={async () => {
				await slide_21_code_el!.update`use params <- my_func(args)
operations`
			}}
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExbjR3NDNmam93YWdwMHBkcnVlbXR5bzhlY21vM2Y2OHc1NHN0dGxxaCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jyu0rExxpCw1nJxqAQ/giphy.webp"
		/>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbDU1ZHF3azdqOGNwMjE2ZjR5b3lkY284NGRtOXp5andmMjh6N3JyYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/MQLao84j8ZSXwxxh1P/giphy.webp"
		/>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
let db = postgres.connect(config)
use <- defer(fn() {
  log.debug("Closing DB connection")
  postgres.close(db)
})

postgres.execute(conn, "...")
          `.trim()}
			/>
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible class="w-full">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						class="w-full"
						code={`
use x <- result.try(fallible_operation())
use y <- result.try(another_fallible_operation())
Ok(x + y)
              `.trim()}
					/>
				</div>
			</Transition>

			<Transition>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
use <- bool.guard(x <= 0, Error("argument must be greater than zero"))
// ...just keep coding
              `.trim()}
					/>
				</div>
			</Transition>

			<Transition class="w-full">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						class="w-full"
						code={`
use <- wisp.log_request(req)
use <- wisp.rescue_crashes
use <- handle_cors(req)
use req <- wisp.handle_head(req)

// The rest of your route handler
              `.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2FqOGh1M2IwYzN2ZGVpeXN5dGQwMXI2MzFqaHpxam8xaGoya2E3OSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cNRdQ1P04K8ebdL7U0/giphy.webp"
		/>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExM2NpNXRydnl4cXM5NjM5b3BxdWVsYTYyYzhtaDRjdXIwb3N4NDRqMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/RjEJg5053SzcI/giphy.webp"
		/>
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/memes/its-all-functions.jpg" />
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="js"
				theme="catppuccin-mocha"
				code={`
fetch('https://pokeapi.co/api/v2/pokemon/zorua').then((response) => {
  return response.json().then((data) => {
    return Promise.all(data.moves.map((move) => {
      return fetch(move.url).then((response) => {
        return response.json().then((data) => {
          return data
        })
      })
    })).then((moves) => {
      return moves
    })
  })
})
    `.trim()}
			/>
		</div>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl">use</h1>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdmhvYW4xeGl3M2Qzd2p4aG84cnhlYmVtdGp2cGJ6emR6bTZ1ZjhlayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/8TweEdaxxfuElKkRxz/giphy.webp"
		/>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible class="w-full">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						class="w-full"
						code={`
use x <- result.try(fallible_operation())
use y <- result.try(another_fallible_operation())
Ok(x + y)
              `.trim()}
					/>
				</div>
			</Transition>

			<Transition class="w-full">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						class="w-full"
						code={`
use <- wisp.log_request(req)
use <- wisp.rescue_crashes
use <- handle_cors(req)
use req <- wisp.handle_head(req)

// The rest of your route handler
              `.trim()}
					/>
				</div>
			</Transition>

			<Transition class="w-full">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						class="w-full"
						code={`
use doubled_num <- fn(num, callback) { callback(num * 2) }
              `.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-7xl">Don't solve problems you don't have</h1>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbHBlZ2hpd2U4NmkzZGhnZmlleHViZGtuM202Ymd4c3V0enJ4eDVjcCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/7AKNM8v3CnW3zhEpUV/giphy.webp"
		/>
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExbzFyaDJzMjFxYWFjemppZ3Y3aTA0YWVhcmZtam9pOWhnOWI3bGtpciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lXu72d4iKwqek/giphy.webp"
		/>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-6">
			<Img src="/screenshots/erika-rowland-using-use-in-gleam.png" />
			<p>https://erikarow.land/notes/using-use-gleam</p>
		</div>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
