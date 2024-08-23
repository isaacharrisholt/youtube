<script lang="ts">
	import lottie from 'lottie-web'
	import { onMount } from 'svelte'

	let animation_container: HTMLDivElement

	type Props = {
		animation: object
		class?: string
		options?: Omit<Parameters<typeof lottie.loadAnimation>[0], 'container' | 'animationData'>
	}

	let { class: classes, animation, options }: Props = $props()

	onMount(() => {
		lottie.loadAnimation({
			container: animation_container,
			animationData: animation,
			...options
		})
	})
</script>

<div bind:this={animation_container} class={classes}></div>
