<script lang="ts">
  import { Button } from "$lib/components/ui/button";
  import { Flame, Waves, Activity } from "lucide-svelte";
  import Spotlight from "$lib/components/custom/SpotLight.svelte";
</script>

<div
  class="relative flex h-[40rem] w-full flex-col items-center justify-center overflow-hidden rounded-lg bg-inherit px-16 antialiased md:items-center md:justify-center lg:px-32"
>
  <div
    class="pointer-events-none absolute inset-0 z-20 h-full w-full [mask-image:radial-gradient(transparent,white)]"
  ></div>

  <Spotlight className="-top-40 left-0 md:left-60 md:-top-20" fill="currentColor" />

  <div class="relative z-10 mx-auto w-full max-w-7xl p-4 pt-20 md:pt-0 flex flex-col items-center">
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
    <div class="flex flex-row gap-6 mt-12 relative">
      <div class="group relative">
        <div class="absolute -inset-1 bg-gradient-to-r from-red-500 to-red-600 rounded-xl blur opacity-40 group-hover:opacity-100 transition duration-500 group-hover:duration-200 animate-tilt"></div>
        <Button class="relative flex items-center gap-2 px-8 py-6 bg-background/60 backdrop-blur-md border border-red-500/10 text-red-500 dark:text-red-400 hover:bg-red-50/10 hover:text-red-100 dark:hover:text-red-100 dark:hover:bg-red-950/20 rounded-xl">
          <Flame class="w-6 h-6" />
          Forest Fire
        </Button>
      </div>

      <div class="group relative">
        <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl blur opacity-40 group-hover:opacity-100 transition duration-500 group-hover:duration-200 animate-tilt"></div>
        <Button class="relative flex items-center gap-2 px-8 py-6 bg-background/60 backdrop-blur-md border border-blue-500/10 text-blue-500 dark:text-blue-400 hover:bg-blue-50/10 hover:text-blue-100 dark:hover:text-blue-100 dark:hover:bg-blue-950/20 rounded-xl">
          <Waves class="w-6 h-6" />
          Flood
        </Button>
      </div>

      <div class="group relative">
        <div class="absolute -inset-1 bg-gradient-to-r from-green-500 to-green-600 rounded-xl blur opacity-40 group-hover:opacity-100 transition duration-500 group-hover:duration-200 animate-tilt"></div>
        <Button class="relative flex items-center gap-2 px-8 py-6 bg-background/60 backdrop-blur-md border border-green-500/10 text-green-500 dark:text-green-400 hover:bg-green-50/10 hover:text-green-100 dark:hover:text-green-100 dark:hover:bg-green-950/20 rounded-xl">
          <Activity class="w-6 h-6" />
          Earthquake
        </Button>
      </div>
    </div>
  </div>
</div>
