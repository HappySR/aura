<script lang="ts">
  import Spotlight from "$lib/components/custom/SpotLight.svelte";
  import BackgroundBoxes from "$lib/components/custom/BackgroundBoxes.svelte";
</script>

<div
  class="relative flex h-[40rem] w-full flex-col items-center justify-center overflow-hidden rounded-lg bg-inherit px-16 antialiased md:items-center md:justify-center lg:px-32"
>
  <div
    class="pointer-events-none absolute inset-0 z-20 h-full w-full [mask-image:radial-gradient(transparent,white)]"
  ></div>

  <Spotlight className="-top-40 left-0 md:left-60 md:-top-20" fill="currentColor" />

  <div class="relative z-10 mx-auto w-full max-w-7xl p-4 pt-20 md:pt-0">
    <h2
      class="bg-gradient-to-b from-foreground to-muted-foreground bg-clip-text text-center text-7xl font-bold text-transparent"
    >
      AURA. <br />
      <span class="text-5xl">resilience & alerts.</span>
    </h2>
    <p class="mx-auto mt-4 max-w-xl text-center text-base font-normal text-muted-foreground">
      A modular and scalable disaster alert system focused on protecting lives through comprehensive
      coverage and location-aware intelligence.
    </p>
  </div>
</div>
