<script>
    const options = ["add", "search", "profile"]
</script>

<div id="wrapper" class="w-full flex justify-around">
    {#each options as option}
        <a href={option} class="w-full border-t-2 not-first:border-l-2 px-2 py-1 border-black text-center hover:cursor-pointer hover:bg-neutral-200">
            <button class="font-bold">
                {option.toUpperCase()}
            </button>
        </a>
    {/each}
</div>
