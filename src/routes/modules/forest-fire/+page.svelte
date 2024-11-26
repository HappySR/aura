<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import {
    Flame,
    Wind,
    Thermometer,
    ArrowRight,
    MapPin,
    AlertTriangle,
    Activity,
    Users,
    Maximize2
  } from "lucide-svelte";
  import { onMount } from "svelte";

  // Location data
  const currentLocation = {
    region: "XYZ Park",
    coordinates: { lat: 26.5833, lng: 93.17 },
    lastUpdated: new Date()
  };

  // Environmental conditions
  let environmentalData = {
    riskLevel: "High",
    temperature: "38°C",
    windSpeed: "25 km/h",
    humidity: "15%",
    lastUpdated: new Date().toLocaleTimeString()
  };

  // Type definitions
  interface FireZone {
    location: string;
    severity: "Critical" | "High" | "Moderate";
    area: string;
    containment: string;
    evacuationStatus: string;
    distance: string;
  }

  interface SafetyGuideline {
    id: number;
    guideline: string;
  }

  // Active fire zone data
  const activeFireZones: FireZone[] = [
    {
      location: "Sector XYZ-001",
      severity: "Critical",
      area: "250 hectares",
      containment: "35%",
      evacuationStatus: "Mandatory",
      distance: "2.5 km away"
    },
    {
      location: "Zone XYZ-002",
      severity: "Moderate",
      area: "120 hectares",
      containment: "65%",
      evacuationStatus: "Advisory",
      distance: "5 km away"
    },
    {
      location: "Region XYZ-003",
      severity: "High",
      area: "180 hectares",
      containment: "45%",
      evacuationStatus: "Mandatory",
      distance: "3.8 km away"
    }
  ];

  // Safety guidelines
  const safetyGuidelines: SafetyGuideline[] = [
    { id: 1, guideline: "Establish and maintain a defensible perimeter around your residence" },
    { id: 2, guideline: "Prepare and regularly update your emergency evacuation strategy" },
    { id: 3, guideline: "Maintain a well-stocked emergency supply kit" },
    { id: 4, guideline: "Stay informed through official news channels and emergency alerts" },
    { id: 5, guideline: "Comply immediately with all evacuation directives" }
  ];

  // Canvas elements
  let mapCanvas: HTMLCanvasElement;
  let ctx: CanvasRenderingContext2D;
  let isFullscreen = false;
  let mapContainer: HTMLDivElement;

  // Map interaction state
  const selectedLocation = {
    lat: currentLocation.coordinates.lat,
    lng: currentLocation.coordinates.lng
  };

  // Fire incident locations
  const fireLocations = [
    { x: 0.3, y: 0.4, intensity: 0.8 },
    { x: 0.7, y: 0.6, intensity: 0.5 },
    { x: 0.5, y: 0.3, intensity: 0.7 }
  ];

  function renderFireEffect(x: number, y: number, intensity: number) {
    if (!ctx) return;

    const width = mapCanvas.width;
    const height = mapCanvas.height;

    const radius = intensity * 30;
    const gradient = ctx.createRadialGradient(
      x * width,
      y * height,
      0,
      x * width,
      y * height,
      radius
    );

    gradient.addColorStop(0, `rgba(255, 0, 0, ${intensity})`);
    gradient.addColorStop(0.5, `rgba(255, 165, 0, ${intensity * 0.6})`);
    gradient.addColorStop(1, "rgba(255, 165, 0, 0)");

    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(x * width, y * height, radius, 0, Math.PI * 2);
    ctx.fill();

    const pulseRadius = radius * (1 + Math.sin(Date.now() / 500) * 0.1);
    const pulseGradient = ctx.createRadialGradient(
      x * width,
      y * height,
      0,
      x * width,
      y * height,
      pulseRadius
    );

    pulseGradient.addColorStop(0, `rgba(255, 69, 0, ${intensity * 0.3})`);
    pulseGradient.addColorStop(1, "rgba(255, 69, 0, 0)");

    ctx.fillStyle = pulseGradient;
    ctx.beginPath();
    ctx.arc(x * width, y * height, pulseRadius, 0, Math.PI * 2);
    ctx.fill();
  }

  function renderMap() {
    if (!ctx) return;

    const width = mapCanvas.width;
    const height = mapCanvas.height;

    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Render grid
    ctx.strokeStyle = "rgba(255,255,255,0.1)";
    ctx.lineWidth = 1;
    const gridSize = 40;

    for (let x = 0; x < width; x += gridSize) {
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, height);
      ctx.stroke();
    }

    for (let y = 0; y < height; y += gridSize) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(width, y);
      ctx.stroke();
    }

    // Render terrain
    const terrainGradient = ctx.createLinearGradient(0, 0, width, height);
    terrainGradient.addColorStop(0, "#E5E7EB");
    terrainGradient.addColorStop(1, "#F3F4F6");

    ctx.fillStyle = terrainGradient;
    ctx.strokeStyle = "#9CA3AF";
    ctx.lineWidth = 1;

    // Primary mountain range
    ctx.beginPath();
    ctx.moveTo(0, height);
    ctx.lineTo(width * 0.2, height * 0.5);
    ctx.lineTo(width * 0.4, height * 0.7);
    ctx.lineTo(width * 0.6, height * 0.4);
    ctx.lineTo(width * 0.8, height * 0.6);
    ctx.lineTo(width, height);
    ctx.closePath();
    ctx.fill();
    ctx.stroke();

    // Secondary mountain range
    ctx.beginPath();
    ctx.moveTo(width * 0.3, height);
    ctx.lineTo(width * 0.5, height * 0.3);
    ctx.lineTo(width * 0.7, height * 0.5);
    ctx.lineTo(width * 0.9, height * 0.2);
    ctx.lineTo(width, height * 0.4);
    ctx.lineTo(width, height);
    ctx.closePath();
    ctx.fill();
    ctx.stroke();

    // Water features
    ctx.strokeStyle = "#3B82F6";
    ctx.beginPath();
    ctx.moveTo(width * 0.7, height * 0.3);
    ctx.quadraticCurveTo(width * 0.8, height * 0.2, width * 0.9, height * 0.3);
    ctx.stroke();

    // Render fire incidents
    fireLocations.forEach((fire) => {
      renderFireEffect(fire.x, fire.y, fire.intensity);
    });

    // Render location marker
    ctx.fillStyle = "#EF4444";
    ctx.beginPath();
    ctx.arc(width / 2, height / 2, 4, 0, Math.PI * 2);
    ctx.fill();

    ctx.strokeStyle = "rgba(239, 68, 68, 0.2)";
    ctx.lineWidth = 4;
    ctx.beginPath();
    ctx.arc(width / 2, height / 2, 8, 0, Math.PI * 2);
    ctx.stroke();
  }

  function toggleFullscreen() {
    if (!document.fullscreenElement) {
      mapContainer.requestFullscreen();
      isFullscreen = true;
    } else {
      document.exitFullscreen();
      isFullscreen = false;
    }
  }

  function handleLocationUpdate(event: MouseEvent) {
    const rect = mapCanvas.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;
    console.log("Map interaction:", { x, y });
  }

  onMount(() => {
    ctx = mapCanvas.getContext("2d")!;

    const handleResize = () => {
      mapCanvas.width = mapContainer.clientWidth;
      mapCanvas.height = mapContainer.clientHeight;
      renderMap();
    };

    handleResize();
    window.addEventListener("resize", handleResize);

    const updateInterval = setInterval(() => {
      environmentalData = {
        ...environmentalData,
        lastUpdated: new Date().toLocaleTimeString()
      };
      renderMap();
    }, 50);

    return () => {
      clearInterval(updateInterval);
      window.removeEventListener("resize", handleResize);
    };
  });
</script>

<div class="animate-fade-in relative min-h-[calc(100vh-64px)] w-full bg-background p-3 sm:p-6">
  <!-- Background Gradient -->
  <div class="absolute inset-0">
    <div
      class="absolute h-full w-full bg-gradient-to-b from-red-500/5 to-orange-500/5 blur-3xl"
    ></div>
  </div>

  <div class="relative z-10 mx-auto mt-10 max-w-7xl space-y-6 sm:mt-10 sm:space-y-12">
    <!-- Header with Mock Map -->
    <div class="flex flex-col items-start justify-between gap-6">
      <div class="w-full space-y-4">
        <h1
          class="bg-gradient-to-r from-red-500 via-orange-500 to-red-500 bg-clip-text text-3xl font-extrabold tracking-tight text-transparent drop-shadow-sm sm:text-5xl"
        >
          Forest Fire Monitor
        </h1>
        <div class="flex flex-wrap items-center gap-2">
          <MapPin class="h-5 w-5 animate-pulse text-red-500" />
          <p class="text-base text-muted-foreground sm:text-lg">
            Monitoring <span class="font-semibold text-red-500/90">{currentLocation.region}</span>
            <span
              class="mt-1 block rounded-full bg-red-500/10 px-2 py-1 text-xs text-red-500 sm:ml-2 sm:mt-0 sm:inline"
            >
              {currentLocation.coordinates.lat.toFixed(4)}, {currentLocation.coordinates.lng.toFixed(
                4
              )}
            </span>
          </p>
        </div>
      </div>
      <!-- Interactive Map -->
      <div
        bind:this={mapContainer}
        class="relative h-[250px] w-full overflow-hidden rounded-xl border border-border/50 bg-background/50 backdrop-blur-sm sm:h-[300px]"
        class:fixed={isFullscreen}
        class:inset-0={isFullscreen}
        class:z-50={isFullscreen}
        class:w-screen={isFullscreen}
        class:h-screen={isFullscreen}
        class:rounded-none={isFullscreen}
      >
        <canvas bind:this={mapCanvas} on:click={handleLocationUpdate} class="h-full w-full"
        ></canvas>

        <!-- Controls -->
        <div class="absolute right-4 top-4 flex gap-2">
          <button
            class="rounded-full bg-background/80 p-2 text-primary transition-colors hover:bg-background/90"
            on:click={toggleFullscreen}
          >
            <Maximize2 class="h-4 w-4" />
          </button>
        </div>

        <div class="absolute bottom-4 right-4">
          <Badge variant="outline" class="bg-red-500/10 text-red-500">Live Location</Badge>
        </div>
      </div>
    </div>

    <!-- Environmental Monitoring -->
    <div class="grid gap-6 sm:grid-cols-1 md:grid-cols-4">
      <div
        class="group col-span-full space-y-4 rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm sm:p-6 md:col-span-2"
      >
        <div class="flex items-center justify-between">
          <h3 class="text-lg font-semibold sm:text-xl">Environmental Conditions</h3>
          <div class="rounded-full bg-red-500/10 p-2">
            <Flame class="h-5 w-5 text-red-500" />
          </div>
        </div>

        <div class="grid grid-cols-2 gap-3 sm:gap-4">
          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <AlertTriangle class="h-4 w-4 text-red-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Risk Assessment</span>
            </div>
            <p class="text-xl font-semibold text-red-500 sm:text-2xl">
              {environmentalData.riskLevel}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Thermometer class="h-4 w-4 text-orange-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Temperature</span>
            </div>
            <p class="text-xl font-semibold text-orange-500 sm:text-2xl">
              {environmentalData.temperature}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Wind class="h-4 w-4 text-blue-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Wind Velocity</span>
            </div>
            <p class="text-xl font-semibold text-blue-500 sm:text-2xl">
              {environmentalData.windSpeed}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Activity class="h-4 w-4 text-emerald-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Relative Humidity</span>
            </div>
            <p class="text-xl font-semibold text-emerald-500 sm:text-2xl">
              {environmentalData.humidity}
            </p>
          </div>
        </div>

        <p class="text-xs text-muted-foreground sm:text-sm">
          Last updated: {environmentalData.lastUpdated}
        </p>
      </div>

      <!-- Safety Protocol -->
      <div
        class="col-span-full rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm sm:p-6 md:col-span-2"
      >
        <div class="mb-4 flex items-center gap-2">
          <Users class="h-5 w-5 text-primary" />
          <h3 class="text-lg font-semibold sm:text-xl">Safety Protocol</h3>
        </div>
        <ul class="space-y-2 sm:space-y-3">
          {#each safetyGuidelines as { guideline }}
            <li class="flex items-center gap-2 text-sm text-muted-foreground sm:text-base">
              <ArrowRight class="h-4 w-4 flex-shrink-0 text-primary" />
              {guideline}
            </li>
          {/each}
        </ul>
      </div>
    </div>

    <!-- Active Fire Zones -->
    <div class="space-y-4 sm:space-y-6">
      <h3 class="text-xl font-semibold sm:text-2xl">Active Fire Incidents</h3>
      <div class="grid gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-3">
        {#each activeFireZones as zone}
          <div
            class="group relative rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm transition-all duration-300 hover:border-red-500/50 sm:p-6"
          >
            <div
              class="absolute -inset-px rounded-xl bg-gradient-to-r from-red-500/10 to-orange-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
            ></div>
            <div class="relative space-y-3 sm:space-y-4">
              <div class="flex items-center justify-between">
                <div class="flex items-center gap-2">
                  <MapPin class="h-5 w-5 text-red-500" />
                  <h4 class="text-sm font-semibold sm:text-base">{zone.location}</h4>
                </div>
                <Badge variant={zone.severity === "Critical" ? "destructive" : "outline"}>
                  {zone.severity}
                </Badge>
              </div>

              <div class="space-y-1 text-xs text-muted-foreground sm:space-y-2 sm:text-sm">
                <p>Affected Area: {zone.area}</p>
                <p>Containment Level: {zone.containment}</p>
                <p>Evacuation Status: {zone.evacuationStatus}</p>
                <p>Proximity: {zone.distance}</p>
              </div>

              <button
                class="inline-flex items-center gap-2 text-xs text-red-500 transition-colors hover:text-red-400 sm:text-sm"
              >
                View Detailed Report
                <ArrowRight class="h-4 w-4" />
              </button>
            </div>
          </div>
        {/each}
      </div>
    </div>
  </div>
</div>
