<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import {
    Flame,
    Waves,
    Activity,
    ArrowRight,
    Shield,
    Users,
    BookOpen,
    Star,
    Boxes,
    Mail,
    Phone,
    MapPin,
    Github,
    Twitter,
    Linkedin,
    Search,
    ChartArea,
  } from "lucide-svelte";
  import { cn } from "$lib/utils";
  import { fade } from "svelte/transition";

  let showSearch = false;
  let searchQuery = "";

  const toggleSearch = (event: MouseEvent) => {
    event.preventDefault();
    event.stopPropagation();
    showSearch = !showSearch;
    if (showSearch) {
      setTimeout(() => {
        document.getElementById("search-input")?.focus();
      }, 100);
    }
  };

  const handleClickOutside = (event: MouseEvent) => {
    const searchModal = document.querySelector(".search-modal");
    const searchButton = document.querySelector(".search-button");

    if (
      showSearch &&
      searchModal &&
      !searchModal.contains(event.target as Node) &&
      !searchButton?.contains(event.target as Node)
    ) {
      showSearch = false;
    }
  };

  const disasterModules = [
    {
      name: "Forest Fire",
      description: "Real-time fire tracking & evacuation routes",
      icon: Flame,
      link: "/modules/forest-fire",
    },
    {
      name: "Flood",
      description: "Flood history, water bed & intensity monitoring",
      icon: Waves,
      link: "/modules/flood",
    },
    {
      name: "Earthquake",
      description: "Seismic history, area & intensity monitoring",
      icon: Activity,
      link: "/modules/earthquake",
    },
  ];

  const coreFeatures = [
    {
      icon: Activity,
      title: "Real-time Alerts",
      description:
        "Get instant notifications about emergencies, weather alerts, evacuation orders and critical updates through SMS, email, and push notifications to stay informed and prepared.",
      link: "/alerts",
    },
    {
      icon: BookOpen,
      title: "History Tracking",
      description:
        "Access detailed historical data of past incidents, response patterns, and outcomes to better understand and prepare for future emergencies.",
      link: "/history",
    },
    {
      icon: Boxes,
      title: "IoT Integration",
      description:
        "Connect with smart sensors and devices to monitor environmental conditions, detect hazards early, and automate emergency responses.",
      link: "/iot",
    },
    {
      icon: Shield,
      title: "Custom Mapping",
      description:
        "Interactive maps with real-time updates, custom overlays, and location-based services to visualize threats and plan evacuation routes.",
      link: "/maps",
    },
    {
      icon: Users,
      title: "Community Network",
      description:
        "Engage with the community, fill surveys, share your thoughts and help everybody stay safe!",
      link: "/community",
    },
    {
      icon: BookOpen,
      title: "Preparedness Training",
      description:
        "Interactive guides, scenario simulations and regular drill schedules for readiness.",
      link: "/training",
    },
  ];

  const emergencyStats = [
    { value: "24/7", label: "Support Available" },
    { value: "98%", label: "Response Rate" },
    { value: "15min", label: "Average Response Time" },
    { value: "10+", label: "Regional Coverage" },
  ];

  const footerLinks = {
    company: [
      { label: "About", href: "/about" },
      { label: "Careers", href: "/careers" },
    ],
    resources: [
      { label: "Documentation", href: "/docs" },
      { label: "Training", href: "/training" },
      { label: "Privacy Policy", href: "/privacy" },
    ],
    contact: {
      email: "aura@aurialis.com",
      phone: "+91 9876-543-210",
      address: "123 Emergency Ave, Safety City, SC 12345",
    },
    social: [
      { icon: Github, href: "https://github.com/aura" },
      { icon: Twitter, href: "https://twitter.com/aura" },
      { icon: Linkedin, href: "https://linkedin.com/company/aura" },
    ],
  };
</script>

<svelte:window on:click={handleClickOutside} />

<!-- Mobile Search Button -->
<button
  onclick={toggleSearch}
  class="fixed bottom-6 right-6 z-30 flex h-14 w-14 items-center justify-center rounded-full bg-primary text-background shadow-lg transition-all hover:scale-105 hover:opacity-90 md:hidden"
>
  <Search class="h-6 w-6" />
</button>

<div
  class="animate-fade-in relative flex min-h-[100vh] w-full flex-col items-center justify-center overflow-hidden bg-inherit px-4"
>
  <!-- Search Modal -->
  {#if showSearch}
    <div
      transition:fade={{ duration: 200 }}
      class="fixed inset-0 z-40 flex items-start justify-center bg-background/80 backdrop-blur-sm"
    >
      <div
        class="search-modal m-4 mt-16 max-h-[90vh] w-full max-w-5xl overflow-y-auto rounded-2xl border border-border/50 bg-background/90 p-4 shadow-2xl backdrop-blur-xl sm:mt-32 sm:p-6"
      >
        <div class="relative">
          <Search
            class="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-muted-foreground/50"
          />
          <input
            id="search-input"
            type="text"
            bind:value={searchQuery}
            placeholder="Search for incidents, reports, or locations..."
            class="w-full rounded-xl border border-border/50 bg-background/50 py-3 pl-12 pr-4 text-foreground/90 placeholder:text-muted-foreground/50 focus:border-primary focus:outline-none focus:ring-2 focus:ring-primary/20"
            autocomplete="off"
            spellcheck="false"
          />
        </div>

        {#if searchQuery}
          <div class="mt-6 space-y-4">
            <!-- Suggested Locations -->
            <div class="space-y-3">
              <div class="flex items-center justify-between">
                <h3 class="text-sm font-medium text-muted-foreground">Suggested Locations</h3>
                <a href="/locations" class="text-xs text-primary hover:underline">View More</a>
              </div>
              <div class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
                <div
                  class="group flex items-center gap-3 rounded-lg border border-border/50 bg-background/50 p-4 transition-all hover:border-primary/50 hover:bg-primary/5 hover:shadow-lg"
                >
                  <div class="rounded-full bg-red-500/10 p-2 group-hover:bg-red-500/20">
                    <MapPin class="h-5 w-5 text-red-500" />
                  </div>
                  <div>
                    <h4 class="font-medium group-hover:text-primary">XYZ Park</h4>
                    <p class="text-sm text-muted-foreground">26.5833° N, 93.17° E</p>
                  </div>
                </div>
                <div
                  class="group flex items-center gap-3 rounded-lg border border-border/50 bg-background/50 p-4 transition-all hover:border-primary/50 hover:bg-primary/5 hover:shadow-lg"
                >
                  <div class="rounded-full bg-blue-500/10 p-2 group-hover:bg-blue-500/20">
                    <MapPin class="h-5 w-5 text-blue-500" />
                  </div>
                  <div>
                    <h4 class="font-medium group-hover:text-primary">ABC Forest</h4>
                    <p class="text-sm text-muted-foreground">26.7456° N, 93.25° E</p>
                  </div>
                </div>
                <div
                  class="group flex items-center gap-3 rounded-lg border border-border/50 bg-background/50 p-4 transition-all hover:border-primary/50 hover:bg-primary/5 hover:shadow-lg"
                >
                  <div class="rounded-full bg-green-500/10 p-2 group-hover:bg-green-500/20">
                    <MapPin class="h-5 w-5 text-green-500" />
                  </div>
                  <div>
                    <h4 class="font-medium group-hover:text-primary">Safety City</h4>
                    <p class="text-sm text-muted-foreground">26.4789° N, 93.08° E</p>
                  </div>
                </div>
              </div>
            </div>

            <!-- Search Companion -->
            <div class="space-y-3">
              <h3 class="text-sm font-medium text-muted-foreground">Search Companion</h3>

              <div class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
                <a
                  href="/modules/forest-fire"
                  class="group relative block overflow-hidden rounded-lg border border-border/50 p-4 transition-all hover:border-red-500/50 hover:shadow-lg"
                >
                  <div
                    class="absolute inset-0 bg-gradient-to-br from-red-500/5 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                  ></div>
                  <div class="flex flex-col gap-3">
                    <div class="flex items-center justify-between">
                      <div class="flex items-center gap-3">
                        <div class="rounded-full bg-red-500/10 p-2 group-hover:bg-red-500/20">
                          <Flame class="h-5 w-5 text-red-500" />
                        </div>
                        <div>
                          <h4 class="font-medium group-hover:text-red-500">Forest Fire Activity</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </a>

                <a
                  href="/modules/flood"
                  class="group relative block overflow-hidden rounded-lg border border-border/50 p-4 transition-all hover:border-blue-500/50 hover:shadow-lg"
                >
                  <div
                    class="absolute inset-0 bg-gradient-to-br from-blue-500/5 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                  ></div>
                  <div class="flex flex-col gap-3">
                    <div class="flex items-center justify-between">
                      <div class="flex items-center gap-3">
                        <div class="rounded-full bg-blue-500/10 p-2 group-hover:bg-blue-500/20">
                          <ChartArea class="h-5 w-5 text-blue-500" />
                        </div>
                        <div>
                          <h4 class="font-medium group-hover:text-blue-500">Flood Activity</h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </a>

                <a
                  href="/modules/earthquake"
                  class="group relative block overflow-hidden rounded-lg border border-border/50 p-4 transition-all hover:border-emerald-500/50 hover:shadow-lg"
                >
                  <div
                    class="absolute inset-0 bg-gradient-to-br from-emerald-500/5 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                  ></div>
                  <div class="flex flex-col gap-3">
                    <div class="flex items-center justify-between">
                      <div class="flex items-center gap-3">
                        <div
                          class="rounded-full bg-emerald-500/10 p-2 group-hover:bg-emerald-500/20"
                        >
                          <Activity class="h-5 w-5 text-emerald-500" />
                        </div>
                        <div>
                          <h4 class="font-medium group-hover:text-emerald-500">
                            Earthquake Activity
                          </h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
            </div>
          </div>
        {:else}
          <div class="mt-4 space-y-2 px-2">
            <p class="text-sm text-muted-foreground/70">Quick Links</p>
            <div class="flex flex-wrap gap-2">
              <Badge
                variant="outline"
                class="cursor-pointer transition-colors hover:border-red-500/50 hover:bg-red-500/10 hover:text-red-500"
                >Forest Fire</Badge
              >
              <Badge
                variant="outline"
                class="cursor-pointer transition-colors hover:border-blue-500/50 hover:bg-blue-500/10 hover:text-blue-500"
                >Flood Alerts</Badge
              >
              <Badge
                variant="outline"
                class="cursor-pointer transition-colors hover:border-yellow-500/50 hover:bg-yellow-500/10 hover:text-yellow-500"
                >Earthquake Data</Badge
              >
              <Badge
                variant="outline"
                class="cursor-pointer transition-colors hover:border-green-500/50 hover:bg-green-500/10 hover:text-green-500"
                >Emergency Contact</Badge
              >
            </div>
          </div>
        {/if}
      </div>
    </div>
  {/if}

  <!-- Background Gradient -->
  <div class="absolute inset-0 flex items-center justify-center">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 to-accent/10 blur-2xl saturate-200 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"
    ></div>
  </div>

  <div class="relative z-10 mx-auto w-full max-w-7xl px-6 py-20 md:py-36">
    <div class="flex flex-col items-center gap-8 md:gap-12">
      <!-- Hero Section -->
      <div
        class="flex w-full flex-col space-y-8 md:flex-row md:items-start md:justify-between md:space-x-12 md:space-y-0"
      >
        <div class="text-center md:flex-1 md:text-left">
          <h1
            class={cn(
              "animate-fade-up bg-gradient-to-tr from-primary via-foreground to-accent bg-clip-text text-5xl font-extrabold tracking-tight text-transparent drop-shadow-sm",
              "xs:text-6xl sm:text-6xl md:text-7xl lg:text-8xl",
            )}
          >
            AURA<span class="text-primary">.</span>
          </h1>
          <p
            class={cn(
              "animate-fade-up mt-4 text-2xl font-semibold tracking-wide text-muted-foreground/90",
              "xs:text-3xl sm:text-4xl md:text-5xl lg:text-6xl",
            )}
          >
            adaptive unified resilience & alerts
          </p>
          <p
            class={cn(
              "animate-fade-up mt-8 max-w-2xl text-base leading-relaxed text-muted-foreground/90 backdrop-blur-sm",
              "sm:text-lg md:text-xl",
            )}
          >
            Your one-stop solution for disaster preparedness, response, and recovery.
          </p>

          <!-- Search Button -->
          <button
            onclick={toggleSearch}
            class="search-button mt-6 hidden items-center gap-2 rounded-full bg-primary px-6 py-3 text-background transition-all hover:scale-105 hover:opacity-90 md:inline-flex"
          >
            <Search class="h-5 w-5" />
            <span class="font-medium"> Explore </span>
          </button>
        </div>

        <!-- Risk Assessment Card -->
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
                  class="flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-r from-primary/20 to-accent/20 backdrop-blur-sm"
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
                <div class="h-1 overflow-hidden rounded-full bg-background/50 backdrop-blur-sm">
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
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Disaster Modules Section -->
      <div class="animate-fade-up mx-auto mt-12 flex w-full max-w-6xl flex-col gap-12">
        <div class="relative mb-12 text-center">
          <div
            class="absolute -inset-[50px] animate-[pulse_6s_ease-in-out_infinite] rounded-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 opacity-30 blur-2xl"
          ></div>
          <div class="flex flex-col items-center justify-center gap-3 md:flex-row">
            <div class="rounded-xl bg-blue-500/10 p-3">
              <Boxes class="h-8 w-8 text-blue-500" />
            </div>
            <h3 class="text-3xl font-bold text-blue-500">Disaster Modules</h3>
          </div>
          <p class="mx-auto mt-4 max-w-2xl text-lg leading-relaxed text-muted-foreground/80">
            Each module is designed to be of utmost utility and ease of use. Completeness and
            reliability are paramount.
          </p>
        </div>

        <div class="grid grid-cols-1 gap-8 sm:grid-cols-3">
          {#each disasterModules as module, i}
            <div
              class={cn(
                "group relative rounded-3xl border border-border/10 bg-background/10 p-8 backdrop-blur-sm transition-all duration-500",
                "hover:scale-[1.02] hover:border-border/30 hover:bg-background/20 hover:shadow-xl",
              )}
            >
              <div
                class={cn(
                  "absolute -inset-1 rounded-[24px] bg-gradient-to-r blur-xl",
                  i === 0
                    ? "from-red-500/10 to-red-500/10"
                    : i === 1
                      ? "from-blue-500/10 to-blue-500/10"
                      : "from-emerald-500/10 to-emerald-500/10",
                )}
              ></div>
              <div
                class={cn(
                  "absolute -inset-1 rounded-[24px] bg-gradient-to-r opacity-0 blur transition duration-500 group-hover:opacity-100",
                  i === 0
                    ? "from-red-500/20 to-red-500/20"
                    : i === 1
                      ? "from-blue-500/20 to-blue-500/20"
                      : "from-emerald-500/20 to-emerald-500/20",
                )}
              ></div>

              <div class="relative flex flex-col gap-4">
                <div class="flex items-center gap-3">
                  <div
                    class={cn(
                      "rounded-xl p-2 transition-colors duration-500",
                      i === 0
                        ? "bg-red-500/10 group-hover:bg-red-500/20"
                        : i === 1
                          ? "bg-blue-500/10 group-hover:bg-blue-500/20"
                          : "bg-emerald-500/10 group-hover:bg-emerald-500/20",
                    )}
                  >
                    <svelte:component
                      this={module.icon}
                      class={cn(
                        "h-6 w-6",
                        i === 0 ? "text-red-500" : i === 1 ? "text-blue-500" : "text-emerald-500",
                        "group-hover:animate-bounce",
                      )}
                    />
                  </div>
                  <h3
                    class={cn(
                      "text-2xl font-medium transition-colors duration-500",
                      i === 0
                        ? "text-red-500 group-hover:text-red-400"
                        : i === 1
                          ? "text-blue-500 group-hover:text-blue-400"
                          : "text-emerald-500 group-hover:text-emerald-400",
                    )}
                  >
                    {module.name}
                  </h3>
                </div>
                <p
                  class="text-muted-foreground/70 transition-colors duration-500 group-hover:text-muted-foreground/90"
                >
                  {module.description}
                </p>
                <div
                  class={cn(
                    "flex items-center gap-2 transition-colors duration-500 group-hover:translate-x-1",
                    i === 0
                      ? "text-red-500 group-hover:text-red-400"
                      : i === 1
                        ? "text-blue-500 group-hover:text-blue-400"
                        : "text-emerald-500 group-hover:text-emerald-400",
                  )}
                >
                  <a href={module.link}>
                    <span>Explore Module</span>
                  </a>
                  <ArrowRight
                    class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
                  />
                </div>
              </div>
            </div>
          {/each}
        </div>
      </div>

      <!-- Core Features -->
      <div class="relative mt-16 w-full">
        <div class="relative mb-12 text-center">
          <div
            class="absolute -inset-[50px] animate-[pulse_6s_ease-in-out_infinite] rounded-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 opacity-30 blur-2xl"
          ></div>
          <div class="flex flex-col items-center justify-center gap-3 md:flex-row">
            <div class="rounded-xl bg-blue-500/10 p-3">
              <Star class="h-8 w-8 text-blue-500" />
            </div>
            <h3 class="text-3xl font-bold text-blue-500">Core Features</h3>
          </div>
          <p class="mx-auto mt-4 max-w-2xl text-lg leading-relaxed text-muted-foreground/80">
            Empowering users with the tools they need to stay prepared and informed.
          </p>
        </div>

        <div
          class="absolute inset-0 rounded-3xl bg-gradient-to-r from-primary/15 via-accent/15 to-primary/15 blur-3xl"
        ></div>
        <div class="relative grid grid-cols-1 gap-8 px-4 py-8 md:grid-cols-3 md:p-8">
          {#each coreFeatures as feature}
            <div
              class={cn(
                "group rounded-2xl border border-border/30 bg-background/40 p-6 backdrop-blur-xl transition-all duration-300",
                "hover:-translate-y-2 hover:border-border/50 hover:shadow-lg md:p-8",
              )}
            >
              <div
                class="mb-6 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 transition-transform duration-300 group-hover:scale-110"
              >
                <feature.icon class="h-6 w-6 text-primary" />
              </div>
              <h3 class="mb-3 text-xl font-semibold">{feature.title}</h3>
              <p class="text-muted-foreground/70">{@html feature.description}</p>
              {#if feature.link}
                <a
                  href={feature.link}
                  class="mt-4 inline-flex items-center gap-2 text-sm text-primary opacity-70 transition-all duration-300 hover:underline hover:opacity-100"
                >
                  Read more
                  <ArrowRight
                    class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
                  />
                </a>
              {/if}
            </div>
          {/each}
        </div>
      </div>

      <!-- Emergency Stats Section -->
      <div class="relative w-full bg-gradient-to-b from-transparent to-primary/5 pt-24">
        <div class="mx-auto max-w-7xl px-6 pb-40">
          <div class="grid grid-cols-1 gap-8 md:grid-cols-4">
            {#each emergencyStats as stat}
              <div class="text-center">
                <div class="text-4xl font-bold text-primary">{stat.value}</div>
                <div class="mt-2 text-sm text-muted-foreground/70">{stat.label}</div>
              </div>
            {/each}
          </div>
        </div>

        <!-- Footer -->
        <footer class="relative w-full bg-background/80 backdrop-blur-xl">
          <div class="mx-auto max-w-7xl px-6 py-12">
            <div class="grid grid-cols-1 gap-8 md:grid-cols-4">
              <!-- Company Info -->
              <div class="space-y-4">
                <h4 class="text-lg font-semibold">Aurialis</h4>
                <ul class="space-y-2">
                  {#each footerLinks.company as link}
                    <li>
                      <a
                        href={link.href}
                        class="text-sm text-muted-foreground/70 transition-colors hover:text-primary"
                      >
                        {link.label}
                      </a>
                    </li>
                  {/each}
                </ul>
              </div>

              <!-- Resources -->
              <div class="space-y-4">
                <h4 class="text-lg font-semibold">Resources</h4>
                <ul class="space-y-2">
                  {#each footerLinks.resources as link}
                    <li>
                      <a
                        href={link.href}
                        class="text-sm text-muted-foreground/70 transition-colors hover:text-primary"
                      >
                        {link.label}
                      </a>
                    </li>
                  {/each}
                </ul>
              </div>

              <!-- Contact Info -->
              <div class="space-y-4">
                <h4 class="text-lg font-semibold">Contact</h4>
                <ul class="space-y-2">
                  <li class="flex items-center gap-2 text-sm text-muted-foreground/70">
                    <Mail class="h-4 w-4" />
                    {footerLinks.contact.email}
                  </li>
                  <li class="flex items-center gap-2 text-sm text-muted-foreground/70">
                    <Phone class="h-4 w-4" />
                    {footerLinks.contact.phone}
                  </li>
                  <li class="flex items-center gap-2 text-sm text-muted-foreground/70">
                    <MapPin class="h-4 w-4" />
                    {footerLinks.contact.address}
                  </li>
                </ul>
              </div>

              <!-- Social Links -->
              <div class="space-y-4">
                <h4 class="text-lg font-semibold">Follow Us</h4>
                <div class="flex gap-4">
                  {#each footerLinks.social as link}
                    <a
                      href={link.href}
                      class="rounded-full bg-primary/10 p-2 text-primary transition-colors hover:bg-primary/20"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      <svelte:component this={link.icon} class="h-5 w-5" />
                    </a>
                  {/each}
                </div>
              </div>
            </div>

            <!-- Copyright -->
            <div class="mt-12 border-t border-border/30 pt-8">
              <div class="flex flex-col items-center justify-between gap-4 text-center md:flex-row">
                <p class="text-sm text-muted-foreground/70">
                  AURA © {new Date().getFullYear()} <b>Aurialis</b>. All rights reserved.
                </p>
                <div class="flex items-center gap-2">
                  <Badge variant="outline" class="text-xs">PDP</Badge>
                  <Badge variant="outline" class="text-xs">CCPA</Badge>
                  <Badge variant="outline" class="text-xs">GDPR</Badge>
                </div>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </div>
  </div>
</div>
