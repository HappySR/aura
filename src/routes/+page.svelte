<script lang="ts">
  import RootMenuBar from "$lib/components/custom/RootMenuBar.svelte";
  import RootSideBar from "$lib/components/custom/RootSideBar.svelte";
  import Spotlight from "$lib/components/custom/SpotLight.svelte";
</script>

<div
  class="relative flex h-[40rem] overflow-hidden rounded-md px-16 antialiased md:items-center md:justify-center lg:px-32"
>
  <Spotlight className="-top-40 left-0 md:left-60 md:-top-20" fill="currentColor" />
  <div class="relative z-10 mx-auto w-full max-w-7xl p-4 pt-20 md:pt-0">
    <h2
      class="bg-gradient-to-b from-foreground to-muted-foreground bg-clip-text text-center text-4xl font-bold text-transparent md:text-7xl"
    >
      AURA. <br />
      all lives matter.
    </h2>
    <p class="mx-auto mt-4 max-w-xl text-center text-base font-normal text-muted-foreground">
      A modular and scalable disaster alert system focused on protecting lives through comprehensive
      coverage and location-aware intelligence.
    </p>
  </div>
</div>
