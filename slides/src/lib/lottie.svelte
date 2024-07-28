<script lang="ts">
	import lottie from 'lottie-web'
	import { onMount } from 'svelte'

	let animation_container: HTMLDivElement

	type Props = {
		class?: string
		animation: object
	}

	let { class: classes, animation }: Props = $props()

	onMount(() => {
		lottie.loadAnimation({
			container: animation_container,
			animationData: animation
		})
	})
</script>

<div bind:this={animation_container} class={classes}></div>
