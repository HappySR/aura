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
        <Button variant="ghost" class="w-full justify-start">
          <Flame class="mr-2 h-4 w-4" />
          Forest Fire
        </Button>
        <Button variant="ghost" class="w-full justify-start">
          <Waves class="mr-2 h-4 w-4" />
          Flood
        </Button>
        <Button variant="ghost" class="w-full justify-start">
          <TreePalm class="mr-2 h-4 w-4" />
          Earthquake
        </Button>
      </div>
    </div>
  </div>
</div>
