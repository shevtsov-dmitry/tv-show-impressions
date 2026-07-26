<script lang="ts">
	import './layout.css';
	import favicon from '$lib/assets/images/favicon-64x64.png';
    import BottomNavPanel from '$lib/navigation/BottomNavPanel.svelte';

	let { children } = $props();
</script>

<svelte:head><link rel="icon" href={favicon} /></svelte:head>

<div class="w-full h-screen flex flex-col overflow-x-hidden">
	<div class="flex-1 min-w-0 overflow-y-auto">
		{@render children()}
	</div>

	<div class="shrink-0">
		<BottomNavPanel />
	</div>
</div>
