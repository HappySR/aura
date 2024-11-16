<script lang="ts">
  import HomeMenuBar from "$lib/components/custom/HomeMenuBar.svelte";
  import HomeSideBar from "$lib/components/custom/HomeSideBar.svelte";
</script>

<div class="hidden md:block">
  <HomeMenuBar />
  <div class="border-t">
    <div class="bg-background">
      <div class="grid lg:grid-cols-5">
        <HomeSideBar class="hidden lg:block" />
      </div>
    </div>
  </div>
</div>
