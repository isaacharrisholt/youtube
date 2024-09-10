<script lang="ts">
	import { Presentation, Slide, Code, Transition, Action } from '@animotion/core'
	import Img from '$lib/img.svelte'
	import message_animation from '$lib/animations/message.json'
	import plug_animation from '$lib/animations/plug.json'
	import Lottie from '$lib/lottie.svelte'
	import { tween } from '@animotion/motion'
	import { cubicInOut } from 'svelte/easing'
	import Stack from '$lib/stack.svelte'

	let slide_1_class = $state('w-[70vw]')
	const SLIDE_3_PATH_LENGTH = 1616.7381591796875
	const slide_3_path_offset = tween(SLIDE_3_PATH_LENGTH, { duration: 800, easing: cubicInOut })
	let slide_6_lottie: Lottie
	let slide_16_lottie: Lottie
</script>

<Presentation
	options={{ transition: 'none', controls: false, progress: false, hash: true }}
	class="bg-[#0b0c0e]"
>
	<!-- 1 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible>
				<img src="/logos/polar/logotype_blue.svg" alt="" class={slide_1_class} />
			</Transition>

			<Transition do={() => (slide_1_class = 'w-[40vw]')}>
				<div class="flex w-[60vw] flex-row items-center justify-center">
					<img src="/logos/lemonsqueezy.svg" alt="" class="w-[32rem]" />
					<img src="/logos/paddle.svg" alt="" class="w-[32rem]" />
				</div>
			</Transition>
		</div>
	</Slide>

	<!-- 2 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img src="/people/birk-jernstrom.jpeg" class="h-[70vh]" />
	</Slide>

	<!-- 3 -->
	<Slide class="h-full place-content-center place-items-center">
		<svg
			width="1000"
			height="1000"
			viewBox="0 0 1200 1200"
			fill="none"
			xmlns="http://www.w3.org/2000/svg"
		>
			<line x1="100" y1="100" x2="100" y2="1108" stroke="white" stroke-width="16" />
			<line x1="100" y1="1100" x2="1100" y2="1100" stroke="white" stroke-width="16" />
			<path
				d="M 108 1100 Q 900 900 1000 200"
				stroke="white"
				stroke-width="8"
				stroke-dasharray={SLIDE_3_PATH_LENGTH}
				stroke-dashoffset={$slide_3_path_offset}
			/>
		</svg>

		<Action
			do={async () => {
				await slide_3_path_offset.to(0)
			}}
		/>
	</Slide>

	<!-- 4 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-start gap-16 text-6xl">
			<Transition>
				<p>🧑‍🤝‍🧑 Crowdfunding</p>
			</Transition>
			<Transition>
				<p>🗝️ Memberships</p>
			</Transition>
			<Transition>
				<p>📦 Products</p>
			</Transition>
			<Transition>
				<p>🎫 Subscriptions</p>
			</Transition>
			<Transition>
				<p>⚖️ Taxes</p>
			</Transition>
		</div>
	</Slide>

	<!-- 5 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNmVycjU2NW91bmlqbW5mY2U3aXlxOWY0cmVkZXlmenI0cXFhcHN4eCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/NdKVEei95yvIY/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 6 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie
			animation={plug_animation}
			class="h-[70vh]"
			options={{ loop: false, autoplay: false }}
			bind:this={slide_6_lottie}
		/>

		<Action
			do={async () => {
				slide_6_lottie.play()
			}}
		/>
	</Slide>

	<!-- 7 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Img src="/screenshots/polar-api-articles-docs.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">docs.polar.sh</p>
		</div>
	</Slide>

	<!-- 8 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-start gap-32">
			<Transition visible>
				<div>
					<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
					<h1 class="font-mono text-6xl">polarsource/polar</h1>
				</div>
			</Transition>

			<Transition>
				<img src="/logos/discord.svg" alt="" class="mt-12 w-[25vw]" />
			</Transition>
		</div>
	</Slide>

	<!-- 9 -->
	<Slide class="h-full place-content-center place-items-center">
		<p class="text-9xl font-bold">V1! 🎉</p>
	</Slide>

	<!-- 10 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmF4ZW9lNjJzdG5vcXdiMzc3M3B1anJibml3eWNyMnJpNDRkcDE2YiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT39CVCn6Eq8Ve9FZu/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 11 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/product-hunt.svg" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 12 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdWNsMXhtOWdqOXlpMXRwNzRpZjduamJhZXU0NjlwYnM1MnJlbzZpOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/h0MTqLyvgG0Ss/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 13 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Transition visible>
				<Img src="/screenshots/polar-api-articles-docs.png" class="h-[60vh]" />
				<p class="font-mono text-7xl font-bold">docs.polar.sh</p>
			</Transition>

			<Transition>
				<p class="font-mono text-7xl font-bold">api.polar.sh/v1</p>
			</Transition>
		</div>
	</Slide>

	<!-- 14 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="w-fit">
			<Code
				lang="typescript"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
import { Polar } from '@polar-sh/sdk'

const api = new Polar()

const authedApi = new Polar({
  accessToken: '<ACCESS_TOKEN>',
})
				`.trim()}
			/>
		</div>
	</Slide>

	<!-- 15 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-row items-center gap-32">
			<img src="/logos/javascript.png" class="h-[30vh]" alt="" />

			<img src="/logos/typescript.svg" class="h-[30vh]" alt="" />

			<img src="/logos/python.svg" class="h-[30vh]" alt="" />
		</div>
	</Slide>

	<!-- 16 -->
	<Slide class="h-full place-content-center place-items-center">
		<Lottie
			animation={message_animation}
			class="w-[60vw]"
			options={{ loop: false, autoplay: false }}
			bind:this={slide_16_lottie}
		/>

		<Action
			do={() => {
				slide_16_lottie.play()
			}}
		/>
	</Slide>

	<!-- 17 -->
	<Slide class="h-full place-content-center place-items-center gap-8">
		<Img
			src="https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZmx1ZHo1MHdxdG1tYndkdjdqeG45bzEyNGIzd2d6eWZsdjltd3VveSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1k4UUaabLlDsBXQtXI/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 18 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition>
			<div class="flex flex-col items-center gap-16">
				<p class="font-mono text-7xl font-bold">/benefits</p>

				<div class="w-fit">
					<Code
						lang="typescript"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
await polar.benefits
  .create({
    type: 'custom',
    description: 'string',
    organizationId: '00000000-0000-0000-0000-000000000000',
    isTaxApplicable: false,
    properties: {
      note: 'string'
    }
  })
						`.trim()}
					/>
				</div>
			</div>
		</Transition>
	</Slide>

	<!-- 19 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/benefits/{'{id}'}/grants</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.benefits
  .grants({
    id: '00000000-0000-0000-0000-000000000000'
  })
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 20 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/products</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.products
  .update({
    id: '00000000-0000-0000-0000-000000000000',
    productUpdate: {
      name: 'string',
      description: 'string',
      isHighlighted: false,
      isArchived: false,
      prices: [{
        id: '00000000-0000-0000-0000-000000000000'
      }],
      medias: ['00000000-0000-0000-0000-000000000000']
    }
  })
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 21 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition>
			<div class="flex flex-col items-center gap-16">
				<p class="font-mono text-7xl font-bold">order.created</p>

				<div class="w-fit">
					<Code
						lang="json"
						class="w-fit !text-4xl"
						theme="catppuccin-mocha"
						code={`
{
  "type": "order.created",
  "data": {
    "created_at": "2024-08-30T00:00:00.000Z",
    "modified_at": "2024-08-30T00:00:00.000Z",
    "id": "00000000-0000-0000-0000-000000000000",
    "amount": 0,
    "tax_amount": 0,
    "currency": "string",
    // ...
  }
}
						`.trim()}
					/>
				</div>
			</div>
		</Transition>
	</Slide>

	<!-- 22 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">subscription.created</p>

			<div class="w-fit">
				<Code
					lang="json"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
{
  "type": "subscription.created",
  "data": {
    "created_at": "2024-08-30T00:00:00.000Z",
    "modified_at": "2024-08-30T00:00:00.000Z",
    "id": "00000000-0000-0000-0000-000000000000",
    "status": "incomplete",
    "current_period_start": "2024-08-30T00:00:00.000Z",
    "current_period_end": "2024-08-30T00:00:00.000Z",
    // ...
  }
}
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 23 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">subscription.updated</p>

			<div class="w-fit">
				<Code
					lang="json"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
{
  "type": "subscription.updated",
  "data": {
    "created_at": "2024-08-30T00:00:00.000Z",
    "modified_at": "2024-08-30T00:00:00.000Z",
    "id": "00000000-0000-0000-0000-000000000000",
    "status": "incomplete",
    "current_period_start": "2024-08-30T00:00:00.000Z",
    "current_period_end": "2024-08-30T00:00:00.000Z",
  	// ...
  }
}
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 24 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/files</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.files
  .update({
    id: '00000000-0000-0000-0000-000000000000',
    filePatch: {
      name: 'string',
      version: 'string'
    }
  })
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 25 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/license-keys</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.licenseKeys
  .list({})
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 26 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/checkout</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.checkouts
  .create({
    productPriceId: '00000000-0000-0000-0000-000000000000',
    successUrl: 'string',
    customerEmail: 'string'
  })
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 27 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/stripe.svg" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 28 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExam5hZzJscDZyMnkzZ3B1YjUxcXVsa210dnh3MDF2bDQxdGMyN3l0ZCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cKnWcUbaxHtekL3Tpe/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 29 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/metrics</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.metrics
  .get({
    startDate: '2024-08-31',
    endDate: '2024-08-31',
    interval: 'year'
  })
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 30 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/orders</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.orders
  .list({})
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 31 -->
	<Slide class="h-full place-content-center place-items-center">
		<Stack class="relative">
			<Img
				src="https://cdn-useast1.kapwing.com/collections/scooby-doo-mask-reveal-meme-template-ewaig.jpg?Expires=1725768007&GoogleAccessId=dev-sa-videoprocessing%40kapwing-dev.iam.gserviceaccount.com&Signature=TdmPlFWvf5z%2Fk48j635DSdq4%2BBX2bB67QPtEo%2FaBjt35T9bZYGPtxn%2B4%2BzunMZygUEXZK%2FlFDWA%2FW85gtIcKq849ejcpzAUZuOnDuzmJVaEPOG8in%2BF%2Ba30pz8pBT8IajQuUf6bkOYdjCT%2FG6Gy%2F3cJmTL2qlofAHcBsPhgbjtv5xzUZ7q01e3ASNIkhWwDBkmcNEQv0ZUhRxOkid5RPWYs17Qhqf70XKK4HKA%2BVLKhWXsUX0uM3QuYh%2BvB1uoQygxlQ2G%2FlJEfP5iklOCdQvAL7uWyvmL8tNRYfixXYbxpvC39qwzZlhqhsbpiUEUMpQmkcfyjB%2B0OZti4U%2B7ZfUw%3D%3D"
				class="h-[70vh]"
			/>

			<div class="absolute top-[9rem] left-[5.5rem] -rotate-5 rounded-full bg-white p-3">
				<img src="/logos/polar/logomark_blue.svg" alt="" class="-mb-1 w-[5vw]" />
			</div>

			<div class="absolute top-[40rem] left-[4.5rem] w-[7vw] -rotate-5 rounded-md bg-white">
				<img src="/logos/stripe.svg" alt="" />
			</div>
		</Stack>
	</Slide>

	<!-- 32 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHcybXUydXhvdTU1dzloemNjczZjOGV3cHMzaGIyYnpndnh4am5ueSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/FfFFgg8UEPiuVqvBQc/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 33 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-start gap-16 text-6xl">
			<Transition>
				<p>📂 File downloads</p>
			</Transition>
			<Transition>
				<p>🗝️ License keys</p>
			</Transition>
			<Transition class="flex flex-col items-start gap-16">
				<p>🎮 Discord</p>
				<p>🐙 GitHub</p>
			</Transition>
		</div>
	</Slide>

	<!-- 34 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/open-source.svg" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 35 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition visible>
			<p class="mb-16 text-9xl font-bold">VAT</p>
		</Transition>

		<Transition>
			<div class="flex w-[70vw] flex-row flex-wrap items-center justify-center gap-8">
				<p>Austria</p>
				<p>Belgium</p>
				<p>Bulgaria</p>
				<p>Canada</p>
				<p>Croatia</p>
				<p>Cyprus</p>
				<p>Czech Republic</p>
				<p>Denmark</p>
				<p>Estonia</p>
				<p>Finland</p>
				<p>France</p>
				<p>Germany</p>
				<p>Greece</p>
				<p>Hungary</p>
				<p>Ireland</p>
				<p>Italy</p>
				<p>Latvia</p>
				<p>Lithuania</p>
				<p>Luxembourg</p>
				<p>Malta</p>
				<p>Netherlands</p>
				<p>Norway</p>
				<p>Poland</p>
				<p>Portugal</p>
				<p>Romania</p>
				<p>Slovakia</p>
				<p>Slovenia</p>
				<p>Spain</p>
				<p>Sweden</p>
				<p>United Kingdom</p>
				<p>United States</p>
			</div>
		</Transition>
	</Slide>

	<!-- 36 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex w-[60vw] flex-row items-center justify-center gap-12">
			<img src="/logos/lemonsqueezy.svg" alt="" class="w-[32rem]" />
			<img src="/logos/paddle.svg" alt="" class="w-[32rem]" />
		</div>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition visible>
			<img src="/logos/polar/logotype_blue.svg" alt="" class="w-[32rem]" />
		</Transition>

		<Transition>
			<p class="mt-16 text-9xl font-bold">4% + 40¢</p>
		</Transition>

		<Transition>
			<p class="mt-16 text-7xl font-bold line-through opacity-80">5% + 50¢</p>
		</Transition>
	</Slide>

	<!-- 37 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXdnbTl6dWVvdmFlamNhbjI4ODA5anlscGtiNXkwZTY1cXkzYWh2dyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o752hBiCT3DgtmFgs/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 38 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/oauth2</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.oauth2
  .token({
    grantType: 'authorization_code',
    clientId: 'string',
    clientSecret: 'string',
    code: 'string',
    redirectUri: 'string'
  })
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 39 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExMXo3N2JraXJianAzYXdta2VzZDdkOTFrbXJ3bjI2bGxwYTJpdXd2OCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/R6gvnAxj2ISzJdbA63/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 40 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
		<h1 class="font-mono text-6xl">polarsource/polar</h1>
	</Slide>

	<!-- 41 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExYnBqeWN3aHhpcGNnNTc1dHJmZWs4djI2OGZxajF6Z2x2ZHJ1c2hndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT5LMWMSpkShp17uiQ/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 42 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">donation.created</p>

			<div class="w-fit">
				<Code
					lang="json"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
{
  "type": "donation.created",
  "data": {
    "created_at": "2024-08-30T00:00:00.000Z",
    "modified_at": "2024-08-30T00:00:00.000Z",
    "id": "00000000-0000-0000-0000-000000000000",
    "amount": 0,
    "currency": "string",
    "message": "string",
    // ...
  }
}
						`.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 43 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3lyY2YxdWkyeGhnNDdjNzdqY25pd2RtanV4ZjI2ZG5zM3phNGViZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/Vf2LIVvSAg3ao2SmfW/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 44 -->
	<Slide class="h-full place-content-center place-items-center">
		<Transition visible>
			<div class="w-fit">
				<Code
					lang="text"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code="/external-organizations"
				/>
			</div>
		</Transition>

		<Transition class="mt-16">
			<div class="w-fit">
				<Code lang="text" class="w-fit !text-4xl" theme="catppuccin-mocha" code="/repositories" />
			</div>
		</Transition>

		<Transition class="mt-32">
			<div class="w-fit">
				<Code lang="text" class="w-fit !text-4xl" theme="catppuccin-mocha" code="pledge.created" />
			</div>
		</Transition>

		<Transition class="mt-16">
			<div class="w-fit">
				<Code lang="text" class="w-fit !text-4xl" theme="catppuccin-mocha" code="pledge.updated" />
			</div>
		</Transition>
	</Slide>

	<!-- 45 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExc2thdjl0cTZqejB4bm5jdzRzeWZ5MDBqbm8yb3ljcnV1Y2x1ZWVkcSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3orieMTsm0AmBymeek/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 46 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col gap-8">
			<Img src="/screenshots/polar-ads-docs.png" class="h-[70vh]" />
			<p class="font-mono text-7xl font-bold">docs.polar.sh/benefits/ads</p>
		</div>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmk5ajlwOWphdXlpdHBjY2xkMDNzdmVybG90aTVqY2Vkc3VtaDk4ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/UwrdbvJz1CNck/giphy.webphttps://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExbmk5ajlwOWphdXlpdHBjY2xkMDNzdmVybG90aTVqY2Vkc3VtaDk4ZiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/UwrdbvJz1CNck/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<p class="font-mono text-7xl font-bold">/articles</p>

			<div class="w-fit">
				<Code
					lang="typescript"
					class="w-fit !text-4xl"
					theme="catppuccin-mocha"
					code={`
await polar.articles
  .get({
    id: '00000000-0000-0000-0000-000000000000'
  })
            `.trim()}
				/>
			</div>
		</div>
	</Slide>

	<!-- 47 -->
	<Slide class="h-full place-content-center place-items-center">
		<p class="mb-16 font-mono text-7xl font-bold">@polar-sh/astro</p>
		<div class="w-fit">
			<Code
				lang="typescript"
				class="w-fit !text-4xl"
				theme="catppuccin-mocha"
				code={`
const { data, error } = await polar
  .upload(posts, {
    organizationId,
  })
  .filter(({ exists }) => !exists)
  .transform(({ entry, article }) => {
    if (entry.data.image) {
      // Add the image as a markdown image
      article.body = \`![](\${entry.data.image.src})\\n\\n\${article.body}\`;
    }
    return article;
  })
         	`.trim()}
			/>
		</div>
	</Slide>

	<!-- 48 -->
	<Slide class="h-full place-content-center place-items-center">
		<div>
			<img src="/logos/github-white.png" alt="" class="mb-16 w-[40vw]" />
			<h1 class="font-mono text-6xl">isaacharrisholt/portfolio-site</h1>
		</div>
	</Slide>

	<!-- 49 -->
	<Slide class="h-full place-content-center place-items-center">
		<div class="flex flex-col items-center gap-16">
			<Transition visible>
				<img src="/logos/polar/logotype_blue.svg" alt="" class="w-[70vw]" />
			</Transition>

			<Transition>
				<p class="mt-8 text-9xl font-bold">4% + 40¢</p>
			</Transition>
		</div>
	</Slide>

	<!-- 50 -->
	<Slide class="h-full place-content-center place-items-center">
		<img src="/logos/product-hunt.svg" class="h-[70vh]" alt="" />
	</Slide>

	<!-- 51 -->
	<Slide class="h-full place-content-center place-items-center">
		<Img
			src="https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExeHZzc3dlN2hpYjJua2VsOGhlODVyNmNhZHpxeTI1MXp6dzR5dWU0eSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xT5LMB2WiOdjpB7K4o/giphy.webp"
			class="h-[70vh]"
		/>
	</Slide>

	<!-- 52 -->
	<Slide class="h-full place-content-center place-items-center"></Slide>
</Presentation>
