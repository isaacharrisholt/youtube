<script lang="ts">
	import { twMerge } from 'tailwind-merge'
	import Stack from './stack.svelte'

	type Props = {
		value: number
		class?: string
		text_class?: string
	}

	let { value, class: classes, text_class }: Props = $props()

	type Colour = {
		r: number
		g: number
		b: number
	}

	const bg_max_colour: Colour = {
		r: 35,
		g: 51,
		b: 40,
	}
	const bg_mid_colour: Colour = {
		r: 55,
		g: 48,
		b: 36,
	}
	const bg_min_colour: Colour = {
		r: 55,
		g: 35,
		b: 36,
	}

	const bar_max_colour: Colour = {
		r: 48,
		g: 208,
		b: 100,
	}
	const bar_mid_colour: Colour = {
		r: 245,
		g: 175,
		b: 56,
	}
	const bar_min_colour: Colour = {
		r: 243,
		g: 54,
		b: 58,
	}

	function lerp(start: number, stop: number, value: number) {
		return start + (stop - start) * value
	}

	function lerp3(start: number, mid: number, stop: number, value: number) {
		return value >= mid ? lerp(mid, stop, value) : lerp(start, mid, value)
	}

	let bg = $derived(
		`rgb(${lerp3(bg_min_colour.r, bg_mid_colour.r, bg_max_colour.r, value / 100)}, ${lerp3(
			bg_min_colour.g,
			bg_mid_colour.g,
			bg_max_colour.g,
			value / 100,
		)},${lerp3(bg_min_colour.b, bg_mid_colour.b, bg_max_colour.b, value / 100)})`,
	)

	let bar = $derived(
		`rgb(${lerp3(bar_min_colour.r, bar_mid_colour.r, bar_max_colour.r, value / 100)}, ${lerp3(
			bar_min_colour.g,
			bar_mid_colour.g,
			bar_max_colour.g,
			value / 100,
		)},${lerp3(bar_min_colour.b, bar_mid_colour.b, bar_max_colour.b, value / 100)})`,
	)
</script>

<Stack class="place-items-center">
	<div class={twMerge('h-64 w-64 rounded-full', classes)} style:background-color={bg}></div>
	<div
		class="h-full w-full rounded-full"
		style="background: conic-gradient({bar} {value * 3.6}deg, {bg} 0deg)"
	></div>
	<div class="grid h-[90%] w-[90%] place-items-center rounded-full" style:background-color={bg}>
		<p class={twMerge('font-mono text-7xl', text_class)} style:color={bar}>
			{Math.round(value)}
		</p>
	</div>
</Stack>
