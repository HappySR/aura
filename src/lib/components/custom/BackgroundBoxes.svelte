<script lang="ts">
  import { cn } from "$lib/utils";

  export let className: string | undefined = undefined;

  const rows = new Array(150).fill(1);
  const cols = new Array(100).fill(1);
</script>

<div
  style="transform: translate(-40%,-60%) skewX(-48deg) skewY(14deg) scale(0.675) rotate(0deg) translateZ(0)"
  class={cn(
    "absolute -top-1/4 left-1/4 z-0 flex  h-full w-full -translate-x-1/2 -translate-y-1/2 p-4 ",
    className
  )}
  {...$$props}
>
  {#each rows as _, i (`row ${i}`)}
    <div class="relative h-8 w-16 border-l border-border">
      {#each cols as _, j (`col ${j}`)}
        <div class="relative h-8 w-16 border-r border-t border-border">
          {#if j % 2 === 0 && i % 2 === 0}
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="pointer-events-none absolute -left-[22px] -top-[14px] h-6 w-10 stroke-[1px] text-muted"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m6-6H6" />
            </svg>
          {/if}
        </div>
      {/each}
    </div>
  {/each}
</div>
