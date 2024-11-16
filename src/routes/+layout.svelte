<script lang="ts">
  import "../app.css";
  import { ModeWatcher } from "mode-watcher";
  import RootMenuBar from "$lib/components/custom/RootMenuBar.svelte";
  import BackgroundBoxes from "$lib/components/custom/BackgroundBoxes.svelte";

  let { children } = $props();
</script>

<ModeWatcher />

<div class="relative min-h-screen">
  <BackgroundBoxes className="fixed inset-0" />
  <div class="relative z-10">
    <RootMenuBar />
    {@render children()}
  </div>
</div>
