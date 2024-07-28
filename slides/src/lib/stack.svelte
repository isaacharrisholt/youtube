<script lang="ts">
	import type { Snippet } from 'svelte'
	import { twMerge } from 'tailwind-merge'

	type Props = {
		class?: string
		children: Snippet
	}

	let { class: classes, children }: Props = $props()
</script>

<div class={twMerge('grid grid-cols-1 [&>*]:col-start-1 [&>*]:row-start-1', classes)}>
	{@render children()}
</div>
