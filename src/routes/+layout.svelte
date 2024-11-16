<script lang="ts">
  import "../app.css";
  import { ModeWatcher } from "mode-watcher";
  import RootMenuBar from "$lib/components/custom/RootMenuBar.svelte";
  import RootSideBar from "$lib/components/custom/RootSideBar.svelte";

  let { children } = $props();
</script>

<ModeWatcher />

<div class="hidden md:block">
  <RootMenuBar />
  <div class="border-t">
    <div class="bg-background">
      <div class="grid lg:grid-cols-5">
        <RootSideBar class="hidden lg:block" />
        <div class="lg:col-span-4">
          {@render children()}
        </div>
      </div>
    </div>
  </div>
</div>
