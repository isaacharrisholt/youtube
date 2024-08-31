<script lang="ts">
	import { Presentation, Slide } from '@animotion/core'
</script>

<Presentation options={{ transition: 'none', controls: false, progress: false, hash: false }}>
	<Slide class="h-full place-content-center place-items-center gap-4">
		<h1 class="text-4xl">Isaac Harris-Holt's video slides</h1>

		<ul class="flex list-none flex-col items-start text-base">
			<li>
				<a href="/videos/043-error-handling-in-gleam" class="text-white">Error handling in Gleam</a>
			</li>
			<li>
				<a href="/videos/044-lustre-ssr" class="text-white">Lustre SSR</a>
			</li>
			<li>
				<a href="/videos/045-deploying-gleam" class="text-white">Deploying Gleam</a>
			</li>
			<li>
				<a href="/videos/046-gleam-is-not-rust" class="text-white">Gleam is not Rust</a>
			</li>
		</ul>
	</Slide>
</Presentation>
