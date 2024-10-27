<script lang="ts">
	import { Presentation, Slide } from '@animotion/core'

	const links = [
		{ href: '/videos/043-error-handling-in-gleam', text: 'Error handling in Gleam' },
		{ href: '/videos/044-lustre-ssr', text: 'Lustre SSR' },
		{ href: '/videos/045-deploying-gleam', text: 'Deploying Gleam' },
		{ href: '/videos/046-gleam-is-not-rust', text: 'Gleam is not Rust' },
		{ href: '/videos/047-polar-for-impatient-devs', text: 'Polar for Impatient Devs' },
		{ href: '/videos/048-lustre-server-components', text: 'Lustre Server Components' },
		{ href: '/videos/049-you-dont-need-loops', text: "You Don't Need Loops" },
	]
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: false }}>
	<Slide class="h-full place-content-center place-items-center gap-4">
		<h1 class="text-4xl">Isaac Harris-Holt's video slides</h1>

		<ul class="flex list-none flex-col items-start text-base">
			{#each links as link}
				<li>
					<a href={link.href} class="text-white">{link.text}</a>
				</li>
			{/each}
		</ul>
	</Slide>
</Presentation>
