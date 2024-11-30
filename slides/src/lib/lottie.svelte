<script lang="ts">
	import type lottie from 'lottie-web'
	import { onMount } from 'svelte'

	let animation_container: HTMLDivElement

	type Props = {
		animation: object
		class?: string
		options?: Omit<Parameters<typeof lottie.loadAnimation>[0], 'container' | 'animationData'>
	}

	let { class: classes, animation, options }: Props = $props()
	let animation_item: ReturnType<typeof lottie.loadAnimation>

	onMount(async () => {
		const { default: lottie } = await import('lottie-web')
		animation_item = lottie.loadAnimation({
			container: animation_container,
			animationData: animation,
			...options,
		})
	})

	export function play() {
		// lottie.play(options?.name)
		animation_item.play()
	}
</script>

<div bind:this={animation_container} class={classes}></div>
