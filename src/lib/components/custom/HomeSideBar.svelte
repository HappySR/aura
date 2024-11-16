<script lang="ts">
  import { cn } from "$lib/utils";
  import { Button } from "$lib/components/ui/button";
  import { Flame, Waves, TreePalm } from "lucide-svelte";

  let className: string | null | undefined = undefined;
  export { className as class };
</script>

<div class={cn("pb-12", className)}>
  <div class="space-y-4 py-4">
    <div class="px-3 py-2">
      <h2 class="mb-2 px-4 text-lg font-semibold tracking-tight">Updates</h2>
      <div class="space-y-1">
        <Button
          variant="secondary"
          class="w-full justify-start text-red-600 hover:bg-red-100 hover:text-red-800 dark:text-red-400 dark:hover:bg-red-700 dark:hover:text-red-100"
        >
          <Flame class="mr-2 h-4 w-4" />
          Forest Fire
        </Button>
        <Button
          variant="ghost"
          class="w-full justify-start text-blue-600 hover:bg-blue-100 hover:text-blue-800 dark:text-blue-400 dark:hover:bg-blue-700 dark:hover:text-blue-100"
        >
          <Waves class="mr-2 h-4 w-4" />
          Flood
        </Button>
        <Button
          variant="ghost"
          class="w-full justify-start text-green-600 hover:bg-green-100 hover:text-green-800 dark:text-green-400 dark:hover:bg-green-700 dark:hover:text-green-100"
        >
          <TreePalm class="mr-2 h-4 w-4" />
          Earthquake
        </Button>
      </div>
    </div>
  </div>
</div>
