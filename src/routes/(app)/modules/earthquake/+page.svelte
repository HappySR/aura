<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import {
    Activity,
    ArrowRight,
    MapPin,
    AlertTriangle,
    Users,
    Maximize2,
    Wifi,
    Signal,
    Clock,
    Thermometer
  } from "lucide-svelte";
  import { onMount } from "svelte";

  // Location data
  const currentLocation = {
    region: "XYZ Valley",
    coordinates: { lat: 26.5833, lng: 93.17 },
    lastUpdated: new Date()
  };

  // Seismic conditions
  let seismicData = {
    riskLevel: "Moderate",
    magnitude: "3.2",
    depth: "10 km",
    intensity: "IV",
    lastUpdated: new Date().toLocaleTimeString()
  };

  // IoT sensor data
  let iotData = {
    latency: "48ms",
    signalStrength: "Good",
    lastSync: new Date().toLocaleTimeString(),
    activeDevices: 12,
    dataQuality: "99%"
  };

  // Type definitions
  interface SeismicZone {
    location: string;
    severity: "Critical" | "High" | "Moderate";
    magnitude: string;
    depth: string;
    intensity: string;
    distance: string;
  }

  interface SafetyGuideline {
    id: number;
    guideline: string;
  }

  // Active seismic zone data
  const activeSeismicZones: SeismicZone[] = [
    {
      location: "Sector XYZ-001",
      severity: "Moderate",
      magnitude: "3.2",
      depth: "10 km",
      intensity: "IV",
      distance: "5 km away"
    },
    {
      location: "Zone XYZ-002",
      severity: "High",
      magnitude: "4.5",
      depth: "15 km",
      intensity: "V",
      distance: "8 km away"
    },
    {
      location: "Region XYZ-003",
      severity: "Critical",
      magnitude: "5.1",
      depth: "8 km",
      intensity: "VI",
      distance: "12 km away"
    }
  ];

  // Safety guidelines
  const safetyGuidelines: SafetyGuideline[] = [
    { id: 1, guideline: "Drop, Cover and Hold On when shaking starts" },
    { id: 2, guideline: "Stay away from windows and exterior walls" },
    { id: 3, guideline: "Have an emergency kit ready and accessible" },
    { id: 4, guideline: "Know your building's evacuation plan" },
    { id: 5, guideline: "Keep updated with official emergency broadcasts" }
  ];

  // Canvas elements
  let mapCanvas: HTMLCanvasElement;
  let ctx: CanvasRenderingContext2D;
  let isFullscreen = false;
  let mapContainer: HTMLDivElement;

  // Seismic epicenter locations
  const seismicLocations = [
    { x: 0.3, y: 0.4, intensity: 0.8 },
    { x: 0.7, y: 0.6, intensity: 0.5 },
    { x: 0.5, y: 0.3, intensity: 0.7 }
  ];

  // Terrain blobs for the map
  const terrainBlobs = [
    { x: 0.2, y: 0.3, radius: 40 },
    { x: 0.5, y: 0.6, radius: 60 },
    { x: 0.8, y: 0.4, radius: 50 },
    { x: 0.3, y: 0.7, radius: 45 },
    { x: 0.7, y: 0.2, radius: 55 },
    { x: 0.4, y: 0.4, radius: 35 },
    { x: 0.6, y: 0.8, radius: 40 }
  ];

  function renderSeismicEffect(x: number, y: number, intensity: number) {
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

    // Draw base terrain color
    ctx.fillStyle = "#cce0da";
    ctx.fillRect(0, 0, width, height);

    // Draw terrain blobs
    terrainBlobs.forEach((blob) => {
      const gradient = ctx.createRadialGradient(
        blob.x * width,
        blob.y * height,
        0,
        blob.x * width,
        blob.y * height,
        blob.radius
      );

      gradient.addColorStop(0, "rgba(255, 255, 255, 0.15)");
      gradient.addColorStop(0.5, "rgba(200, 200, 200, 0.1)");
      gradient.addColorStop(1, "rgba(150, 150, 150, 0)");

      ctx.fillStyle = gradient;
      ctx.beginPath();
      ctx.arc(blob.x * width, blob.y * height, blob.radius, 0, Math.PI * 2);
      ctx.fill();
    });

    // Draw seismic effects
    seismicLocations.forEach((location) => {
      renderSeismicEffect(location.x, location.y, location.intensity);
    });
  }

  onMount(() => {
    if (mapCanvas) {
      ctx = mapCanvas.getContext("2d")!;
      renderMap();

      // Animate map
      const animate = () => {
        renderMap();
        requestAnimationFrame(animate);
      };
      animate();
    }
  });
</script>

<div class="relative flex min-h-[100vh] w-full flex-col bg-inherit">
  <!-- Background Gradient -->
  <div class="absolute inset-0">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 to-accent/10 blur-2xl"
    ></div>
  </div>

  <div class="relative z-10 mx-auto mt-10 w-full max-w-7xl space-y-6 p-6">
    <div class="flex flex-col items-start justify-between gap-6 md:flex-row">
      <div class="w-full space-y-4 md:w-1/2">
        <h1
          class="bg-gradient-to-r from-emerald-500 via-emerald-400 to-emerald-500 bg-clip-text text-3xl font-extrabold tracking-tight text-transparent drop-shadow-sm sm:text-5xl"
        >
          Earthquake Monitor
        </h1>
        <div class="flex flex-wrap items-center gap-2">
          <MapPin class="h-5 w-5 animate-pulse text-emerald-500" />
          <p class="text-base text-muted-foreground sm:text-lg">
            Monitoring <span class="font-semibold text-emerald-500/90"
              >{currentLocation.region}</span
            >
            <span
              class="mt-1 block rounded-full bg-emerald-500/10 px-2 py-1 text-xs text-emerald-500 sm:ml-2 sm:mt-0 sm:inline"
            >
              {currentLocation.coordinates.lat.toFixed(4)}, {currentLocation.coordinates.lng.toFixed(
                4
              )}
            </span>
          </p>
        </div>
      </div>
    </div>

    <!-- Main Grid -->
    <div class="grid gap-6 md:grid-cols-4">
      <!-- Map Section -->
      <div class="group relative col-span-full md:col-span-2">
        <div
          bind:this={mapContainer}
          class="relative aspect-[4/3] overflow-hidden rounded-xl border border-border/50 bg-background/50 backdrop-blur-sm"
        >
          <canvas bind:this={mapCanvas} class="h-full w-full" width="800" height="600"></canvas>

          <button
            class="absolute right-4 top-4 rounded-lg bg-background/50 p-2 opacity-0 backdrop-blur-sm transition-opacity duration-200 hover:bg-background/80 group-hover:opacity-100"
            on:click={() => (isFullscreen = !isFullscreen)}
          >
            <Maximize2 class="h-4 w-4" />
          </button>

          <div class="absolute bottom-4 left-4 space-y-1">
            <div class="flex items-center gap-2 text-sm">
              <MapPin class="h-4 w-4 text-[#046e4b]" />
              <span class="text-[#046e4b]">{currentLocation.region}</span>
            </div>
            <div class="text-xs text-muted-foreground dark:text-gray-600">
              Last updated: {currentLocation.lastUpdated.toLocaleTimeString()}
            </div>
          </div>
        </div>
      </div>

      <!-- Seismic Conditions -->
      <div
        class="col-span-full space-y-4 rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm sm:p-6 md:col-span-2"
      >
        <div class="flex items-center justify-between">
          <h3 class="text-lg font-semibold sm:text-xl">Seismic Conditions</h3>
          <div class="rounded-full bg-red-500/10 p-2">
            <Activity class="h-5 w-5 text-red-500" />
          </div>
        </div>

        <div class="grid grid-cols-2 gap-3 sm:gap-4">
          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <AlertTriangle class="h-4 w-4 text-yellow-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Risk Level</span>
            </div>
            <p class="text-xl font-semibold text-yellow-500 sm:text-2xl">
              {seismicData.riskLevel}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Activity class="h-4 w-4 text-red-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Magnitude</span>
            </div>
            <p class="text-xl font-semibold text-red-500 sm:text-2xl">
              {seismicData.magnitude}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Thermometer class="h-4 w-4 text-blue-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Depth</span>
            </div>
            <p class="text-xl font-semibold text-blue-500 sm:text-2xl">
              {seismicData.depth}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Activity class="h-4 w-4 text-emerald-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Intensity</span>
            </div>
            <p class="text-xl font-semibold text-emerald-500 sm:text-2xl">
              {seismicData.intensity}
            </p>
          </div>
        </div>

        <p class="text-xs text-muted-foreground sm:text-sm">
          Last updated: {seismicData.lastUpdated}
        </p>
      </div>

      <!-- IoT Sensor Status -->
      <div
        class="group col-span-full space-y-4 rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm sm:p-6 md:col-span-2"
      >
        <div class="flex items-center justify-between">
          <h3 class="text-lg font-semibold sm:text-xl">IoT Sensor Network</h3>
          <div class="rounded-full bg-blue-500/10 p-2">
            <Wifi class="h-5 w-5 text-blue-500" />
          </div>
        </div>

        <div class="grid grid-cols-2 gap-3 sm:gap-4">
          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Clock class="h-4 w-4 text-green-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Latency</span>
            </div>
            <p class="text-xl font-semibold text-green-500 sm:text-2xl">
              {iotData.latency}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Signal class="h-4 w-4 text-blue-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Signal Strength</span>
            </div>
            <p class="text-xl font-semibold text-blue-500 sm:text-2xl">
              {iotData.signalStrength}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Users class="h-4 w-4 text-purple-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Active Devices</span>
            </div>
            <p class="text-xl font-semibold text-purple-500 sm:text-2xl">
              {iotData.activeDevices}
            </p>
          </div>

          <div class="space-y-2 rounded-lg bg-background/50 p-3 sm:p-4">
            <div class="flex items-center gap-2">
              <Activity class="h-4 w-4 text-yellow-500" />
              <span class="text-xs text-muted-foreground sm:text-sm">Data Quality</span>
            </div>
            <p class="text-xl font-semibold text-yellow-500 sm:text-2xl">
              {iotData.dataQuality}
            </p>
          </div>
        </div>

        <p class="text-xs text-muted-foreground sm:text-sm">
          Last synced: {iotData.lastSync}
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

    <!-- Active Seismic Zones -->
    <div class="space-y-4 sm:space-y-6">
      <h3 class="text-xl font-semibold sm:text-2xl">Active Seismic Zones</h3>
      <div class="grid gap-4 sm:grid-cols-2 sm:gap-6 lg:grid-cols-3">
        {#each activeSeismicZones as zone}
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
                <p>Magnitude: {zone.magnitude}</p>
                <p>Depth: {zone.depth}</p>
                <p>Intensity: {zone.intensity}</p>
                <p>Distance: {zone.distance}</p>
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
