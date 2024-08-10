<script lang="ts">
	import { twMerge } from 'tailwind-merge'
	type Props = {
		src: string
		class?: string
	}

	let { src, class: classes }: Props = $props()
</script>

<img {src} alt="" class={twMerge('w-full rounded-xl shadow-2xl', classes)} />
