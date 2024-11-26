<script lang="ts">
  import "../../app.css";
  import { ModeWatcher } from "mode-watcher";
  import RootMenuBar from "$lib/components/custom/RootMenuBar.svelte";

  let { children } = $props();
</script>

<ModeWatcher />

<div class="relative min-h-screen">
  <div class="relative z-10">
    <RootMenuBar />
    {@render children()}
  </div>
</div>
