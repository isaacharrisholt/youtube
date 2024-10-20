<script lang="ts">
	import '../styles/app.css'

	let { children } = $props()
</script>

<svelte:head>
	<title>Isaac Harris-Holt | Slides</title>
</svelte:head>

{@render children()}
