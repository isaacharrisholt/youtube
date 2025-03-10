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
	import CallStackTable from './call-stack-table.svelte'

	let slide_6_code_el_1: Code
	let slide_6_code_el_2: Code

	let slide_7_show_js = $state(true)
	let slide_7_code_el_1: Code
	let slide_7_code_el_2: Code

	let slide_9_show_woo = $state(false)
	let slide_9_show_wobble = $state(true)
	let slide_9_show_wibble_2 = $state(false)
	let slide_9_show_wibble_3 = $state(false)

	let slide_10_code_el: Code

	let slide_11_code_el: Code
	let slide_11_call_stack_table: CallStackTable

	let slide_13_code_el: Code
	let slide_13_call_stack_table: CallStackTable

	let slide_19_call_stack_table: CallStackTable

	let slide_20_call_stack_table: CallStackTable

	let slide_21_code_el: Code

	let slide_22_code_el: Code
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: true }}>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/logos/lucy/gleam-lucy.svg" class="h-[32rem] -rotate-10" default />
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie animation={knowledge_owl_animation} class="h-[80vh]" />
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<Img src="/logos/javascript.png" class="h-[50vh]" default />
			<Img src="/logos/python.svg" class="h-[50vh]" default />
			<Img src="/logos/rust-logo-white.png" class="h-[50vh]" default />
		</div>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExazM2eDE5c2s4ZTN0bDVtOW5vYmI4cGwzOGFsNjVlZTU3MG5qNXJiOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/MZQkUm97KTI1gI8sUj/giphy.webp"
		/>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-9xl line-through">for</h1>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div>
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
fn wibble() {
	wibble()
}
				`.trim()}
					bind:this={slide_6_code_el_1}
				/>
			</div>

			<div>
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
fn wobble() {
	woo()
}

fn woo() {
	wobble()
}
				`.trim()}
					bind:this={slide_6_code_el_2}
				/>
			</div>
		</div>

		<Action
			do={async () => {
				slide_6_code_el_2.selectLines`10000`
				slide_6_code_el_1.selectLines`2`
			}}
			undo={async () => {
				slide_6_code_el_2.selectLines`*`
				slide_6_code_el_1.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				slide_6_code_el_1.selectLines`10000`
				slide_6_code_el_2.selectLines`1-3`
			}}
			undo={async () => {
				slide_6_code_el_1.selectLines`2`
				slide_6_code_el_2.selectLines`10000`
			}}
		/>

		<Action
			do={async () => {
				for (let i = 0; i < 4; i++) {
					await slide_6_code_el_2.selectLines`6`
					await slide_6_code_el_2.selectLines`2`
				}
				await slide_6_code_el_2.selectLines`6`
			}}
			undo={async () => {
				slide_6_code_el_2.selectLines`2`
			}}
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			{#if slide_7_show_js}
				<Transition visible>
					<div class="min-w-[45dvw]">
						<Code
							lang="javascript"
							theme="catppuccin-mocha"
							code={`
function countdown(n) {
	while (n > 0) {
		console.log(n)
		sleep(1)
		n -= 1
	}
	console.log("Blastoff! 🚀")
}
					`.trim()}
							bind:this={slide_7_code_el_1}
						/>
					</div>
				</Transition>
			{/if}

			<Transition>
				<div class="min-w-[45dvw]">
					<Code
						lang="rust"
						theme="catppuccin-mocha"
						code={`
fn countdown(n) {
	io.println(int.to_string(n))
	sleep(1)
	countdown(n - 1)
}						
            `.trim()}
						bind:this={slide_7_code_el_2}
					/>
				</div>
			</Transition>
		</div>

		<Action
			do={async () => {
				slide_7_code_el_1.selectLines`10000`
				slide_7_code_el_2.selectLines`4`
			}}
			undo={async () => {
				slide_7_code_el_1.selectLines`*`
				slide_7_code_el_2.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				slide_7_code_el_1.selectLines`5`
			}}
			undo={async () => {
				slide_7_code_el_1.selectLines`10000`
			}}
		/>

		<Transition
			do={async () => {
				slide_7_show_js = false
				slide_7_code_el_2.selectLines`*`
			}}
			undo={async () => {
				slide_7_show_js = true
				slide_7_code_el_2.selectLines`4`
			}}
		/>

		<Action
			do={async () => {
				slide_7_code_el_2.update`fn countdown(n) {
  case n {
    0 -> io.println("Blastoff! 🚀")
    _ -> {
        io.println(int.to_string(n))
        sleep(1)
        countdown(n - 1)
    }
  }
}`
			}}
			undo={async () => {
				slide_7_code_el_2.update`fn countdown(n) {
	io.println(int.to_string(n))
	sleep(1)
	countdown(n - 1)
}`
			}}
		/>

		<Action
			do={async () => {
				slide_7_code_el_2.selectLines`2-3`
			}}
			undo={async () => {
				slide_7_code_el_2.selectLines`*`
			}}
		/>

		<Action
			do={async () => {
				slide_7_code_el_2.selectLines`*`
				slide_7_code_el_2.update`fn countdown(n) {
  case n > 0 {
    False -> io.println("Blastoff! 🚀")
    True -> {
        io.println(int.to_string(n))
        sleep(1)
        countdown(n - 1)
    }
  }
}`
			}}
			undo={async () => {
				slide_7_code_el_2.selectLines`2-3`
				slide_7_code_el_2.update`fn countdown(n) {
  case n {
    0 -> io.println("Blastoff! 🚀")
    _ -> {
        io.println(int.to_string(n))
        sleep(1)
        countdown(n - 1)
    }
  }
}`
			}}
		/>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition visible>
			<div class="flex flex-col items-center gap-4">
				<h1 class="text-7xl">Recursion basics:</h1>

				<Transition>
					<ol class="flex list-decimal flex-col items-start gap-4">
						<li>Make your function call itself</li>

						<Transition>
							<li>Add a base case</li>
						</Transition>
					</ol>
				</Transition>
			</div>
		</Transition>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex h-[60dvh] flex-col items-center justify-end gap-4">
			{#if slide_9_show_woo}
				<div class="w-full border-2 border-white p-6 font-mono text-4xl" transition:fade>woo()</div>
			{/if}

			{#if slide_9_show_wobble}
				<div class="w-full border-2 border-white p-6 font-mono text-4xl" transition:fade>
					wobble()
				</div>
			{/if}

			{#if slide_9_show_wibble_3}
				<div class="w-full border-2 border-white p-6 font-mono text-4xl" transition:fade>
					wibble()
				</div>
			{/if}

			{#if slide_9_show_wibble_2}
				<div class="w-full border-2 border-white p-6 font-mono text-4xl" transition:fade>
					wibble()
				</div>
			{/if}

			<div class="w-full border-2 border-white p-6 font-mono text-4xl">wibble()</div>

			<h1 class="mt-8 w-[40dvw] font-mono text-5xl">Call stack</h1>

			<Action do={() => (slide_9_show_woo = true)} undo={() => (slide_9_show_woo = false)} />
			<Action do={() => (slide_9_show_woo = false)} undo={() => (slide_9_show_woo = true)} />
			<Action do={() => (slide_9_show_wobble = false)} undo={() => (slide_9_show_wobble = true)} />
			<Action
				do={() => (slide_9_show_wibble_2 = true)}
				undo={() => (slide_9_show_wibble_2 = false)}
			/>
			<Action
				do={() => (slide_9_show_wibble_3 = true)}
				undo={() => (slide_9_show_wibble_3 = false)}
			/>
		</div>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="javascript"
				theme="catppuccin-mocha"
				code={`
function factorial(n) {
  let result = 1
	while (n > 1) {
		result = n * result
		n -= 1
	}
	return result
}
					`.trim()}
				bind:this={slide_10_code_el}
			/>
		</div>

		<Action
			do={() => slide_10_code_el.selectLines`4`}
			undo={() => slide_10_code_el.selectLines`*`}
		/>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-1 grid-rows-2 place-items-center gap-16">
			<div>
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
fn factorial(n) {
	case n > 1 {
		False -> 1
		True -> n * factorial(n - 1)
	}
}
					`.trim()}
					bind:this={slide_11_code_el}
				/>
			</div>

			<Transition>
				<CallStackTable
					bind:this={slide_11_call_stack_table}
					variable="n"
					function_call="factorial(n)"
					num_rows={3}
				/>
			</Transition>

			<Action
				do={async () => {
					slide_11_call_stack_table.set(0, '3', '3 * factorial(2) = ?')
				}}
				undo={async () => {
					slide_11_call_stack_table.clear(0)
				}}
			/>

			<Action
				do={async () => {
					slide_11_call_stack_table.set(1, '2', '2 * factorial(1) = ?')
				}}
				undo={async () => {
					slide_11_call_stack_table.clear(1)
				}}
			/>

			<Action
				do={async () => {
					slide_11_call_stack_table.set(2, '1', '1')
				}}
				undo={async () => {
					slide_11_call_stack_table.clear(2)
				}}
			/>

			<Action
				do={async () => {
					slide_11_call_stack_table.set(1, '2', '2 * 1 = 2')
				}}
				undo={async () => {
					slide_11_call_stack_table.set(1, '2', '2 * factorial(1) = ?')
				}}
			/>

			<Action
				do={async () => {
					slide_11_call_stack_table.set(0, '3', '3 * 2 = 6')
				}}
				undo={async () => {
					slide_11_call_stack_table.set(0, '3', '3 * factorial(2) = ?')
				}}
			/>
		</div>
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="javascript"
				theme="catppuccin-mocha"
				code={`
function doubleNums(nums) {
	let newList = []
	for (const num of nums) {
		newList.push(num * 2)
	}
	return newList
}
					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-1 grid-rows-2 place-items-center gap-16">
			<Transition visible>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
fn double_nums(nums) {
	case nums {
		[] -> []
		[num, ..rest] -> {
			let rest_doubled = double_nums(rest)
			[num * 2, ..rest_doubled]
		}
	}
}
					`.trim()}
						bind:this={slide_13_code_el}
					/>
				</div>
			</Transition>

			<Transition order={6}>
				<CallStackTable
					bind:this={slide_13_call_stack_table}
					variable="nums"
					function_call="double_nums(nums)"
					num_rows={4}
				/>
			</Transition>
		</div>

		<Action
			order={1}
			do={async () => {
				slide_13_code_el.selectLines`3`
			}}
			undo={async () => {
				slide_13_code_el.selectLines`*`
			}}
		/>

		<Action
			order={2}
			do={async () => {
				slide_13_code_el.selectLines`4`
			}}
			undo={async () => {
				slide_13_code_el.selectLines`3`
			}}
		/>

		<Action
			order={3}
			do={async () => {
				slide_13_code_el.selectLines`5`
			}}
			undo={async () => {
				slide_13_code_el.selectLines`4`
			}}
		/>

		<Action
			order={4}
			do={async () => {
				slide_13_code_el.selectLines`6`
			}}
			undo={async () => {
				slide_13_code_el.selectLines`5`
			}}
		/>

		<Action
			order={5}
			do={async () => {
				slide_13_call_stack_table.set(0, '[1, 2, 3]', '[2, ..double_nums([1, 2, 3])]')
				slide_13_call_stack_table.set(1, '[2, 3]', '[4, ..double_nums([2, 3])]')
				slide_13_call_stack_table.set(2, '[3]', '[6, ..double_nums([])]')
				slide_13_call_stack_table.set(3, '[]', '[]')
				slide_13_code_el.selectLines`*`
			}}
			undo={async () => {
				slide_13_call_stack_table.clear()
				slide_13_code_el.selectLines`6`
			}}
		/>

		<Action
			order={7}
			do={async () => {
				slide_13_call_stack_table.set(2, '[3]', '[6]')
			}}
			undo={async () => {
				slide_13_call_stack_table.set(2, '[3]', '[6, ..double_nums([])]')
			}}
		/>

		<Action
			order={8}
			do={async () => {
				slide_13_call_stack_table.set(1, '[2, 3]', '[4, 6]')
			}}
			undo={async () => {
				slide_13_call_stack_table.set(1, '[2, 3]', '[4, ..double_nums([2, 3])]')
			}}
		/>

		<Action
			order={9}
			do={async () => {
				slide_13_call_stack_table.set(0, '[1, 2, 3]', '[2, 4, 6]')
			}}
			undo={async () => {
				slide_13_call_stack_table.set(0, '[1, 2, 3]', '[2, ..double_nums([1, 2, 3])]')
			}}
		/>

		<Action
			order={10}
			do={async () => {
				slide_13_code_el.selectLines`5-6`
			}}
			undo={async () => {
				slide_13_code_el.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/diagrams/shared-linked-list.png" default />
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-1 grid-rows-2 place-items-center gap-16">
			<Transition visible>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
fn find(list, value) {
	case list {
		[] -> False
		[item, ..] if item == value -> True
		[_, ..rest] -> find(rest, value)
	}
}
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
fn fib(n) {
  case n {
	  num if num <= 2 -> 1
	  _ -> fib(n - 1) + fib(n - 2)
  }
}
						`.trim()}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl">Yes*</h1>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex h-[60dvh] flex-col items-center justify-end gap-4">
			<div class="w-full border-2 border-white p-6 font-mono text-4xl">wibble()</div>

			<div class="w-full border-2 border-white p-6 font-mono text-4xl">wibble()</div>

			<div class="w-full border-2 border-white p-6 font-mono text-4xl">wibble()</div>

			<h1 class="mt-8 w-[40dvw] font-mono text-5xl">Call stack</h1>
		</div>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="text-9xl">Tail call optimisation</h1>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-1 grid-rows-2 place-items-center gap-16">
			<Transition visible>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
fn count_up_forever(from) {
	io.println(int.to_string(from))
	count_up_forever(from + 1)
}
					`.trim()}
					/>
				</div>
			</Transition>

			<Action
				do={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(1)')
					slide_19_call_stack_table.set(1, '1', 'count_up_forever(2)')
					slide_19_call_stack_table.set(2, '2', 'count_up_forever(3)')
					slide_19_call_stack_table.set(3, '3', 'count_up_forever(4)')
				}}
				undo={async () => {
					slide_19_call_stack_table.clear()
				}}
			/>

			<Transition>
				<CallStackTable
					bind:this={slide_19_call_stack_table}
					variable="from"
					function_call="count_up_forever(from)"
					num_rows={4}
				/>
			</Transition>

			<Action
				do={async () => {
					slide_19_call_stack_table.clear()
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(1)')
				}}
				undo={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(1)')
					slide_19_call_stack_table.set(1, '1', 'count_up_forever(2)')
					slide_19_call_stack_table.set(2, '2', 'count_up_forever(3)')
					slide_19_call_stack_table.set(3, '3', 'count_up_forever(4)')
				}}
			/>

			<Action
				do={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(2)')
				}}
				undo={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(1)')
				}}
			/>

			<Action
				do={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(3)')
				}}
				undo={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(2)')
				}}
			/>

			<Action
				do={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(4)')
				}}
				undo={async () => {
					slide_19_call_stack_table.set(0, '0', 'count_up_forever(3)')
				}}
			/>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="grid grid-cols-1 grid-rows-2 place-items-center gap-16">
			<Transition visible>
				<div>
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={`
fn find(list, value) {
	case list {
		[] -> False
		[item, ..] if item == value -> True
		[_, ..rest] -> find(rest, value)
	}
}
					`.trim()}
					/>
				</div>
			</Transition>

			<Action
				do={async () => {
					slide_20_call_stack_table.set(0, '[1, 2, 3]', 'find([2, 3], 3)')
					slide_20_call_stack_table.set(1, '[2, 3]', 'find([3], 3)')
					slide_20_call_stack_table.set(2, '[3]', 'True')
				}}
				undo={async () => {
					slide_20_call_stack_table.clear()
				}}
			/>

			<Transition>
				<CallStackTable
					bind:this={slide_20_call_stack_table}
					variable="list"
					function_call="find(list, 3)"
					num_rows={3}
				/>
			</Transition>

			<Action
				do={async () => {
					slide_20_call_stack_table.set(1, '[2, 3]', 'True')
				}}
				undo={async () => {
					slide_20_call_stack_table.set(1, '[2, 3]', 'find([3], 3)')
				}}
			/>

			<Action
				do={async () => {
					slide_20_call_stack_table.set(0, '[1, 2, 3]', 'True')
				}}
				undo={async () => {
					slide_20_call_stack_table.set(0, '[1, 2, 3]', 'find([2, 3], 3)')
				}}
			/>

			<Action
				do={async () => {
					slide_20_call_stack_table.clear(1)
					slide_20_call_stack_table.clear(2)
				}}
				undo={async () => {
					slide_20_call_stack_table.set(1, '[2, 3]', 'find([3], 3)')
					slide_20_call_stack_table.set(2, '[3]', 'True')
				}}
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
fn double_nums(nums) {
	case nums {
		[] -> []
		[num, ..rest] -> {
			let rest_doubled = double_nums(rest)
			[num * 2, ..rest_doubled]
		}
	}
}
					`.trim()}
				bind:this={slide_21_code_el}
			/>
		</div>

		<Action
			do={async () => {
				slide_21_code_el.update`fn double_nums(nums) {
	case nums {
		[] -> []
		[num, ..rest] -> [num * 2, ..double_nums(rest)]
	}
}`
			}}
			undo={async () => {
				slide_21_code_el.update`fn double_nums(nums) {
	case nums {
		[] -> []
		[num, ..rest] -> {
			let rest_doubled = double_nums(rest)
			[num * 2, ..rest_doubled]
		}
	}
}`
			}}
		/>

		<Action
			do={async () => {
				slide_21_code_el.selectLines`4`
			}}
			undo={async () => {
				slide_21_code_el.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
fn double_nums(nums, acc) {
	case nums {
		[] -> acc
		[num, ..rest] -> {
			let new_acc = [num * 2, ..acc]
			double_nums(rest, new_acc)
		}
	}
}
					`.trim()}
				bind:this={slide_22_code_el}
			/>
		</div>

		<Action
			do={async () => {
				slide_22_code_el.selectLines`4-7`
			}}
			undo={async () => {
				slide_22_code_el.selectLines`*`
			}}
		/>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<h1 class="font-mono text-7xl">double_nums([1, 2, 3], [])</h1>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<Code
				lang="gleam"
				theme="catppuccin-mocha"
				code={`
pub fn double_nums(nums) {
	let reversed = do_double_nums(nums, [])
	list.reverse(reversed)
}

fn do_double_nums(nums, acc) {
	// Recursive function...
}
					`.trim()}
			/>
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible class="w-[70dvw]">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={'list.map([1, 2, 3], fn(n) { n * 2 }) // [2, 4, 6]'}
					/>
				</div>
			</Transition>

			<Transition class="w-[70dvw]">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={'list.filter([1, 2, 3], keeping: int.is_odd) // [1, 3]'}
					/>
				</div>
			</Transition>

			<Transition class="w-[70dvw]">
				<div class="w-full">
					<Code
						lang="gleam"
						theme="catppuccin-mocha"
						code={'list.contains([1, 2, 3], 3) // True'}
					/>
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<div class="w-full">
				<Code
					lang="gleam"
					theme="catppuccin-mocha"
					code={`
[1, 2, 3]
|> list.filter(keeping: int.is_odd)
|> list.map(fn(n) { n * 2 })
// [2, 6]
						`.trim()}
				/>
			</div>

			<div class="w-full">
				<Code
					lang="javascript"
					theme="catppuccin-mocha"
					code={`
[1, 2, 3]
  .filter((n) => n % 2 != 0)
  .map((n) => n * 2)
// [2, 6]
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
