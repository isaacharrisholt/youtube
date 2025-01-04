<script lang="ts">
	import { tick } from 'svelte'
	import { fade } from 'svelte/transition'

	class CallStackTable {
		public variable: string
		public function_call: string
		public num_rows: number
		public rows: Array<{ variable: string; function_call: string }> = $state([])

		constructor(variable: string, function_call: string, rows: number) {
			this.variable = variable
			this.function_call = function_call
			if (rows < 1) {
				this.num_rows = 1
			} else {
				this.num_rows = rows
			}
			for (let i = 0; i < this.num_rows; i++) {
				this.rows.push({ variable: '', function_call: '' })
			}
		}
	}

	let {
		variable,
		function_call,
		num_rows,
	}: {
		variable: string
		function_call: string
		num_rows: number
	} = $props()

	const call_stack_table = new CallStackTable(variable, function_call, num_rows)

	export function set(idx: number, variable: string, function_call: string) {
		call_stack_table.rows[idx] = { variable, function_call }
	}

	function clear(): void
	function clear(idx: number): void
	export function clear(idx?: number) {
		if (idx) {
			call_stack_table.rows[idx] = { variable: '', function_call: '' }
		} else {
			for (let i = 0; i < call_stack_table.num_rows; i++) {
				call_stack_table.rows[i] = { variable: '', function_call: '' }
			}
		}
	}
</script>

<div class="min-w-[60dvw] text-left font-mono">
	<div class="grid h-16 w-full grid-cols-[1fr_2fr] gap-4 border-b-4 border-white py-2">
		<div class="font-bold">{call_stack_table.variable}</div>
		<div class="font-bold">{call_stack_table.function_call}</div>
	</div>
	{#each call_stack_table.rows as row}
		<div class="grid h-16 w-full grid-cols-[1fr_2fr] gap-4 border-b-2 border-white py-2">
			<div>
				{#if row.variable}
					<p transition:fade>
						{@html row.variable}
					</p>
				{/if}
			</div>
			<div>
				{#if row.function_call}
					<p transition:fade>
						{@html row.function_call}
					</p>
				{/if}
			</div>
		</div>
	{/each}
</div>
