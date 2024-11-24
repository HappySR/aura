<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import { Button } from "$lib/components/ui/button";
  import { Flame, Waves, Activity, ArrowRight, Shield, Users, BookOpen } from "lucide-svelte";
</script>

<div
  class="animate-fade-in relative flex min-h-[100vh] w-full flex-col items-center justify-center overflow-hidden bg-inherit px-4"
>
  <div class="absolute inset-0 flex items-center justify-center">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 to-accent/10 blur-2xl saturate-200 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"
    ></div>
  </div>

  <div class="relative z-10 mx-auto w-full max-w-7xl px-6 py-20 md:py-36">
    <div class="flex flex-col items-center gap-8 md:gap-12">
      <div
        class="flex w-full flex-col space-y-8 md:flex-row md:items-start md:justify-between md:space-x-12 md:space-y-0"
      >
        <div class="text-center md:flex-1 md:text-left">
          <h1
            class="animate-fade-up xs:text-5xl bg-gradient-to-br from-foreground via-foreground/80 to-muted-foreground bg-clip-text text-4xl font-bold tracking-tight text-transparent sm:text-6xl md:text-7xl lg:text-8xl"
          >
            AURA.
          </h1>
          <p
            class="animate-fade-up xs:text-3xl mt-2 text-2xl font-medium text-muted-foreground/90 sm:text-4xl md:text-5xl lg:text-6xl"
          >
            Adaptive Unified Resilience & Alerts
          </p>
          <p
            class="animate-fade-up mt-6 max-w-2xl text-lg leading-relaxed text-muted-foreground/80 sm:text-xl"
          >
            A comprehensive multi-disaster alert system prioritizing usability, reliability and
            preparedness through modular design and location-aware intelligence.
          </p>
        </div>

        <div class="animate-fade-up group relative w-full md:w-2/5">
          <div
            class="absolute -inset-1 rounded-2xl bg-gradient-to-r from-primary/50 to-accent/50 opacity-30 blur-md transition duration-300 group-hover:opacity-100 group-hover:duration-200"
          ></div>
          <div
            class="absolute -inset-[100px] animate-[pulse_4s_ease-in-out_infinite] rounded-full bg-gradient-to-r from-primary/20 via-accent/20 to-primary/20 opacity-30 blur-3xl"
          ></div>
          <div
            class="absolute -inset-[50px] animate-[pulse_6s_ease-in-out_infinite_1s] rounded-full bg-gradient-to-r from-accent/20 via-primary/20 to-accent/20 opacity-20 blur-2xl"
          ></div>
          <div
            class="relative overflow-hidden rounded-xl border border-border/30 bg-background/90 shadow-xl backdrop-blur-xl transition-all duration-300 group-hover:border-border/50"
          >
            <div class="space-y-4 p-6">
              <div class="flex items-center justify-between">
                <h3
                  class="bg-gradient-to-r from-primary to-accent bg-clip-text text-2xl font-semibold text-transparent"
                >
                  Risk Assessment
                </h3>
                <div
                  class="flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-r from-primary/20 to-accent/20"
                >
                  <div class="h-2 w-2 animate-pulse rounded-full bg-primary"></div>
                </div>
              </div>

              <div class="space-y-2">
                <div class="flex items-center space-x-3 text-muted-foreground/80">
                  <Activity class="h-4 w-4 text-primary" />
                  <span class="text-sm"
                    >Dynamic Risk Score: <Badge variant="outline">High</Badge></span
                  >
                </div>
                <div class="h-1 overflow-hidden rounded-full bg-background/50">
                  <div
                    class="h-full w-2/3 animate-pulse rounded-full bg-gradient-to-r from-primary to-accent"
                  ></div>
                </div>
              </div>

              <div class="space-y-3">
                <p class="text-sm text-muted-foreground/70">
                  Real-time hazard monitoring and geographic risk analysis for your location
                </p>

                <div class="space-y-1 text-sm text-muted-foreground/70">
                  <div class="flex items-center space-x-2">
                    <Flame class="h-3 w-3 text-red-500" />
                    <span
                      >Forest fire risk <Badge variant="outline">Critical</Badge> - High temperature</span
                    >
                  </div>
                  <div class="text-xs">Based on weather patterns • Updated live</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="animate-fade-up mx-auto mt-24 flex w-full max-w-6xl flex-col gap-12">
        <div class="relative mb-8 text-center">
          <div
            class="absolute -inset-[50px] animate-[pulse_6s_ease-in-out_infinite] rounded-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 opacity-30 blur-2xl"
          ></div>
          <h3
            class="animate-gradient bg-gradient-to-r from-primary via-accent to-primary bg-clip-text text-3xl font-bold text-transparent"
          >
            Disaster Monitoring Modules
          </h3>
          <p class="mx-auto mt-4 max-w-2xl text-lg leading-relaxed text-muted-foreground/80">
            Choose a specialized module to access real-time monitoring, alerts and preparedness
            resources tailored to specific disaster types
          </p>
        </div>
        <div class="grid grid-cols-1 gap-8 sm:grid-cols-3">
          <div
            class="group relative rounded-3xl border border-border/10 bg-background/10 p-8 backdrop-blur-sm transition-all duration-500 hover:scale-[1.02] hover:border-border/30 hover:bg-background/20 hover:shadow-xl"
          >
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-red-500/10 to-orange-500/10 blur-xl"
            ></div>
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-red-500/20 to-orange-500/20 opacity-0 blur transition duration-500 group-hover:opacity-100"
            ></div>
            <div class="relative flex flex-col gap-4">
              <div class="flex items-center gap-3">
                <div
                  class="rounded-xl bg-red-500/10 p-2 transition-colors duration-500 group-hover:bg-red-500/20"
                >
                  <Flame class="h-6 w-6 text-red-500 group-hover:animate-bounce" />
                </div>
                <h3
                  class="text-2xl font-medium text-red-500 transition-colors duration-500 group-hover:text-red-400"
                >
                  Forest Fire
                </h3>
              </div>
              <p
                class="text-muted-foreground/70 transition-colors duration-500 group-hover:text-muted-foreground/90"
              >
                Real-time fire tracking & evacuation routes
              </p>
              <div
                class="flex items-center gap-2 text-red-500 transition-colors duration-500 group-hover:translate-x-1 group-hover:text-red-400"
              >
                <span>Explore Module</span>
                <ArrowRight
                  class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
                />
              </div>
            </div>
          </div>

          <div
            class="group relative rounded-3xl border border-border/10 bg-background/10 p-8 backdrop-blur-sm transition-all duration-500 hover:scale-[1.02] hover:border-border/30 hover:bg-background/20 hover:shadow-xl"
          >
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-blue-500/10 to-cyan-500/10 blur-xl"
            ></div>
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-blue-500/20 to-cyan-500/20 opacity-0 blur transition duration-500 group-hover:opacity-100"
            ></div>
            <div class="relative flex flex-col gap-4">
              <div class="flex items-center gap-3">
                <div
                  class="rounded-xl bg-blue-500/10 p-2 transition-colors duration-500 group-hover:bg-blue-500/20"
                >
                  <Waves class="h-6 w-6 text-blue-500 group-hover:animate-bounce" />
                </div>
                <h3
                  class="text-2xl font-medium text-blue-500 transition-colors duration-500 group-hover:text-blue-400"
                >
                  Flood
                </h3>
              </div>
              <p
                class="text-muted-foreground/70 transition-colors duration-500 group-hover:text-muted-foreground/90"
              >
                Flood warnings & water level monitoring
              </p>
              <div
                class="flex items-center gap-2 text-blue-500 transition-colors duration-500 group-hover:translate-x-1 group-hover:text-blue-400"
              >
                <span>Explore Module</span>
                <ArrowRight
                  class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
                />
              </div>
            </div>
          </div>

          <div
            class="group relative rounded-3xl border border-border/10 bg-background/10 p-8 backdrop-blur-sm transition-all duration-500 hover:scale-[1.02] hover:border-border/30 hover:bg-background/20 hover:shadow-xl"
          >
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-emerald-500/10 to-green-500/10 blur-xl"
            ></div>
            <div
              class="absolute -inset-1 rounded-[24px] bg-gradient-to-r from-emerald-500/20 to-green-500/20 opacity-0 blur transition duration-500 group-hover:opacity-100"
            ></div>
            <div class="relative flex flex-col gap-4">
              <div class="flex items-center gap-3">
                <div
                  class="rounded-xl bg-emerald-500/10 p-2 transition-colors duration-500 group-hover:bg-emerald-500/20"
                >
                  <Activity class="h-6 w-6 text-emerald-500 group-hover:animate-bounce" />
                </div>
                <h3
                  class="text-2xl font-medium text-emerald-500 transition-colors duration-500 group-hover:text-emerald-400"
                >
                  Earthquake
                </h3>
              </div>
              <p
                class="text-muted-foreground/70 transition-colors duration-500 group-hover:text-muted-foreground/90"
              >
                Seismic activity & safety protocols
              </p>
              <div
                class="flex items-center gap-2 text-emerald-500 transition-colors duration-500 group-hover:translate-x-1 group-hover:text-emerald-400"
              >
                <span>Explore Module</span>
                <ArrowRight
                  class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Core Features -->
      <div class="relative mt-16 w-full">
        <div
          class="absolute inset-0 rounded-3xl bg-gradient-to-r from-primary/5 via-accent/5 to-primary/5 blur-3xl"
        ></div>
        <div class="relative grid grid-cols-1 gap-8 p-8 md:grid-cols-3">
          <div
            class="group rounded-2xl border border-border/30 bg-background/40 p-8 backdrop-blur-xl transition-all duration-300 hover:border-border/50"
          >
            <div
              class="mb-6 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 transition-transform duration-300 group-hover:scale-110"
            >
              <Shield class="h-6 w-6 text-primary" />
            </div>
            <h3 class="mb-3 text-xl font-semibold">Comprehensive Coverage</h3>
            <p class="text-muted-foreground/70">
              Deep, focused implementation for each disaster type with purposeful feature
              development.
            </p>
          </div>

          <div
            class="group rounded-2xl border border-border/30 bg-background/40 p-8 backdrop-blur-xl transition-all duration-300 hover:border-border/50"
          >
            <div
              class="mb-6 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 transition-transform duration-300 group-hover:scale-110"
            >
              <Users class="h-6 w-6 text-primary" />
            </div>
            <h3 class="mb-3 text-xl font-semibold">Community Network</h3>
            <p class="text-muted-foreground/70">
              Local assistance platforms and real-time crisis communication for community support.
            </p>
          </div>

          <div
            class="group rounded-2xl border border-border/30 bg-background/40 p-8 backdrop-blur-xl transition-all duration-300 hover:border-border/50"
          >
            <div
              class="mb-6 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 transition-transform duration-300 group-hover:scale-110"
            >
              <BookOpen class="h-6 w-6 text-primary" />
            </div>
            <h3 class="mb-3 text-xl font-semibold">Preparedness Training</h3>
            <p class="text-muted-foreground/70">
              Interactive guides, scenario simulations and regular drill schedules for readiness.
            </p>
          </div>
        </div>
      </div>

      <!-- Decorative bottom wave -->
      <div class="absolute bottom-0 left-0 w-full overflow-hidden leading-none">
        <svg
          class="relative block h-[100px] w-full"
          data-name="Layer 1"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 1200 120"
          preserveAspectRatio="none"
        >
          <path
            d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z"
            class="fill-primary/5"
          ></path>
        </svg>
      </div>
    </div>
  </div>
</div>
