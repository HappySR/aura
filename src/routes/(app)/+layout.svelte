<script lang="ts">
  import RootMenuBar from "$lib/components/custom/RootMenuBar.svelte";

  let { children } = $props();
</script>

<div class="relative min-h-screen">
  <div class="relative z-10">
    <RootMenuBar />
    {@render children()}
  </div>
</div>
