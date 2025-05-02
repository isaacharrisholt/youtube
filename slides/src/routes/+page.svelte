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
		{ href: '/videos/050-using-use-in-gleam', text: 'Using use in Gleam' },
		{ href: '/videos/051-learn-recursion-with-gleam', text: 'Learn recursion with Gleam' },
		{ href: '/videos/052-phantom-types-in-gleam', text: 'Phantom types in Gleam' },
		{ href: '/videos/053-squirrel', text: 'Squirrel' },
		{ href: '/videos/054-chess-tournament-announcement', text: 'Chess tournament announcement' },
		{ href: '/videos/055-decoders-in-gleam', text: 'Decoders in Gleam' },
	]
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: false }}>
	<Slide class="h-full place-content-center place-items-center gap-4">
		<h1 class="text-4xl">Isaac Harris-Holt's video slides</h1>

		<ol
			class="flex max-w-2xl list-none flex-wrap items-start justify-center gap-x-3 gap-y-4 text-base"
		>
			{#each links as link}
				<li>
					<a
						href={link.href}
						class="rounded-full border bg-blue-800/30 py-0.5 px-2 text-blue-400 no-underline"
						>{link.text}</a
					>
				</li>
			{/each}
		</ol>
	</Slide>
</Presentation>
