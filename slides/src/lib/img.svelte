<script lang="ts">
	import { twMerge } from 'tailwind-merge'
	type Props = {
		src: string
		class?: string
		default?: boolean
	}

	let { src, class: classes, default: def = false }: Props = $props()
</script>

<img {src} alt="" class={twMerge('h-[70vh] w-full', !def && 'rounded-xl shadow-2xl', classes)} />
