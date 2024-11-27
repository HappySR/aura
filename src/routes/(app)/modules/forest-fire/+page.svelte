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
    Maximize2,
    Wifi,
    Github,
    Twitter,
    Linkedin,
    Phone,
    Mail,
    Signal,
    Clock,
    ChartArea,
    History,
    DollarSign,
    MessageCircle
  } from "lucide-svelte";
  import { onMount } from "svelte";
  // @ts-ignore
  import * as d3 from "d3";

  // Location data
  const currentLocation = {
    region: "XYZ Park",
    coordinates: { lat: 26.5833, lng: 93.17 },
    lastUpdated: new Date()
  };

  // Environmental conditions
  let environmentalData = {
    riskLevel: "Critical",
    temperature: "258°C",
    windSpeed: "15 km/h",
    humidity: "7%",
    lastUpdated: new Date().toLocaleTimeString()
  };

  // IoT sensor data
  let iotData = {
    latency: "34ms",
    signalStrength: "Good",
    lastSync: new Date().toLocaleTimeString(),
    activeDevices: 8,
    dataQuality: "94.7%"
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

  interface HistoricalIncident {
    id: number;
    date: string;
    location: string;
    severity: "Critical" | "High" | "Moderate";
    area: string;
    duration: string;
    casualties: number;
    propertyDamage: string;
    containmentTime: string;
    description: string;
  }

  // Active fire zone data
  const activeFireZones: FireZone[] = [
    {
      location: "Sector XYZ-001",
      severity: "Critical",
      area: "2.5 km²",
      containment: "35%",
      evacuationStatus: "Mandatory",
      distance: "2.5 km away"
    },
    {
      location: "Zone XYZ-002",
      severity: "Moderate",
      area: "1.2 km²",
      containment: "65%",
      evacuationStatus: "Advisory",
      distance: "5 km away"
    },
    {
      location: "Region XYZ-003",
      severity: "High",
      area: "1.8 km²",
      containment: "45%",
      evacuationStatus: "Mandatory",
      distance: "3.8 km away"
    }
  ];

  // Historical fire incidents
  const historicalIncidents: HistoricalIncident[] = [
    {
      id: 1,
      date: "2023-06-15",
      location: "Sector XYZ-001",
      severity: "Critical",
      area: "4.5 km²",
      duration: "72 hours",
      casualties: 0,
      propertyDamage: "₹16.5 Cr",
      containmentTime: "96 hours",
      description:
        "One of the largest fires in the region's history, requiring extensive aerial support."
    },
    {
      id: 2,
      date: "2023-08-22",
      location: "Zone XYZ-002",
      severity: "High",
      area: "2.8 km²",
      duration: "48 hours",
      casualties: 0,
      propertyDamage: "₹1 Cr",
      containmentTime: "60 hours",
      description:
        "Rapid spread due to strong winds, successfully contained with minimal structural damage."
    },
    {
      id: 3,
      date: "2023-09-30",
      location: "Region XYZ-003",
      severity: "Moderate",
      area: "1.5 km²",
      duration: "36 hours",
      casualties: 0,
      propertyDamage: "₹66 Lakh",
      containmentTime: "48 hours",
      description: "Early detection allowed for quick response and minimal environmental impact."
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

  const footerLinks = {
    company: [
      { label: "About", href: "/about" },
      { label: "Careers", href: "/careers" }
    ],
    resources: [
      { label: "Documentation", href: "/docs" },
      { label: "Training", href: "/training" },
      { label: "Privacy Policy", href: "/privacy" }
    ],
    contact: {
      email: "aura@aurialis.com",
      phone: "+91 9876-543-210",
      address: "123 Emergency Ave, Safety City, SC 12345"
    },
    social: [
      { icon: Github, href: "https://github.com/aura" },
      { icon: Twitter, href: "https://twitter.com/aura" },
      { icon: Linkedin, href: "https://linkedin.com/company/aura" }
    ]
  };

  // Canvas elements
  let mapCanvas: HTMLCanvasElement;
  let mapContainer: HTMLDivElement;
  let isFullscreen = false;
  let svg: d3.Selection<SVGSVGElement, unknown, null, undefined>;

  // Fire incident locations
  const fireLocations = [
    { x: 0.3, y: 0.4, intensity: 0.8 },
    { x: 0.7, y: 0.6, intensity: 0.5 },
    { x: 0.5, y: 0.3, intensity: 0.7 }
  ];

  async function renderMap() {
    // Clear previous SVG
    d3.select(mapContainer).select("svg").remove();

    const width = mapContainer.clientWidth;
    const height = mapContainer.clientHeight;

    // Create SVG
    svg = d3.select(mapContainer).append("svg").attr("width", width).attr("height", height);

    try {
      // Load Assam GeoJSON data
      const response = await fetch("/assam.geojson");
      const assamData = await response.json();

      // Create projection
      const projection = d3.geoMercator().fitSize([width, height], assamData);

      // Create path generator
      const path = d3.geoPath().projection(projection);

      // Create color scale
      const colorScale = d3.scaleSequential(d3.interpolateReds).domain([0, 1]);

      // Draw districts
      svg
        .selectAll("path")
        .data(assamData.features)
        .enter()
        .append("path")
        // @ts-ignore
        .attr("d", path)
        .attr("fill", () => colorScale(Math.random())) // Random colors for demo
        .attr("stroke", "#fff")
        .attr("stroke-width", 0.5);

      // Add fire markers
      fireLocations.forEach((fire) => {
        // @ts-ignore
        const [x, y] = projection([
          currentLocation.coordinates.lng + (fire.x - 0.5) * 2,
          currentLocation.coordinates.lat + (fire.y - 0.5) * 2
        ]);

        const gradient = svg
          .append("defs")
          .append("radialGradient")
          .attr("id", `fire-gradient-${fire.x}-${fire.y}`);

        gradient.append("stop").attr("offset", "0%").attr("stop-color", "rgba(255, 0, 0, 1)");

        gradient.append("stop").attr("offset", "100%").attr("stop-color", "rgba(255, 165, 0, 0)");

        svg
          .append("circle")
          .attr("cx", x)
          .attr("cy", y)
          .attr("r", fire.intensity * 20)
          .attr("fill", `url(#fire-gradient-${fire.x}-${fire.y})`);
      });
    } catch (error) {
      console.error("Error loading map data:", error);
    }
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

  function handleLocationUpdate(event: MouseEvent | KeyboardEvent) {
    const rect = mapContainer.getBoundingClientRect();
    // @ts-ignore
    const x = event.clientX - rect.left;
    // @ts-ignore
    const y = event.clientY - rect.top;
    console.log("Map interaction:", { x, y });
  }

  onMount(() => {
    renderMap();

    const handleResize = () => {
      renderMap();
    };

    window.addEventListener("resize", handleResize);

    const updateInterval = setInterval(() => {
      environmentalData = {
        ...environmentalData,
        lastUpdated: new Date().toLocaleTimeString()
      };
      renderMap();
    }, 5000);

    return () => {
      clearInterval(updateInterval);
      window.removeEventListener("resize", handleResize);
    };
  });
</script>

<div
  class="min-h-screen w-full bg-gradient-to-b from-background to-background/95 px-4 py-6 md:px-8 lg:px-12"
>
  <div class="mx-auto max-w-7xl space-y-8">
    <!-- Header Section -->
    <div class="mt-20 flex flex-col gap-8 lg:flex-row lg:items-start lg:justify-between">
      <!-- Title and Stats -->
      <div class="w-full space-y-6 lg:w-1/2">
        <div class="space-y-6">
          <h1
            class="bg-gradient-to-r from-red-500 via-orange-500 to-red-500 bg-clip-text text-center text-4xl font-bold tracking-tight text-transparent md:text-5xl lg:text-left lg:text-6xl"
          >
            Forest Fire
          </h1>

          <div
            class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all hover:border-red-500/50 hover:bg-amber-500/10"
          >
            <div class="flex items-center gap-4">
              <div class="rounded-full bg-red-500/20 p-3">
                <MapPin class="h-6 w-6 text-red-500" />
              </div>
              <div>
                <p class="text-sm text-muted-foreground">Current Region</p>
                <p class="text-2xl font-bold text-red-500">{currentLocation.region}</p>
                <p class="mt-1 text-sm text-muted-foreground">
                  <Badge variant="outline" class="flex items-center gap-2">
                    <Clock class="h-3 w-3" />
                    Updated at
                    <span class="font-medium text-red-500"
                      >{currentLocation.lastUpdated.toLocaleTimeString()}</span
                    >
                  </Badge>
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="grid grid-cols-2 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          <div
            class="group rounded-xl border border-border/50 bg-background/20 p-4 backdrop-blur-sm transition-all hover:border-red-500/50"
          >
            <div class="flex h-full items-center justify-center gap-3">
              <div class="rounded-full bg-red-500/10 p-2">
                <ChartArea class="h-5 w-5 text-red-500" />
              </div>
              <div>
                <p class="text-sm font-medium text-muted-foreground">Area affected</p>
                <p class="text-lg font-bold text-red-500">89 km²</p>
              </div>
            </div>
          </div>

          <div
            class="group rounded-xl border border-border/50 bg-background/20 p-4 backdrop-blur-sm transition-all hover:border-red-500/50"
          >
            <div class="flex h-full items-center justify-center gap-3">
              <div class="rounded-full bg-red-500/10 p-2">
                <DollarSign class="h-5 w-5 text-red-500" />
              </div>
              <div>
                <p class="text-sm text-muted-foreground">Property Damage</p>
                <p class="font-medium text-red-500">₹25 Cr</p>
              </div>
            </div>
          </div>

          <div
            class="group col-span-2 rounded-xl border border-border/50 bg-background/20 p-4 backdrop-blur-sm transition-all hover:border-red-500/50 lg:col-span-1"
          >
            <div class="flex h-full items-center justify-center gap-3">
              <div class="rounded-full bg-red-500/10 p-2">
                <AlertTriangle class="h-5 w-5 text-red-500" />
              </div>
              <div>
                <p class="text-sm text-muted-foreground">Risk Level</p>
                <p class="font-medium text-red-500">Critical</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Interactive Map -->
      <div
        bind:this={mapContainer}
        class="relative h-[300px] w-full overflow-hidden rounded-xl border border-border/50 bg-background/50 backdrop-blur-sm transition-all lg:h-[400px] lg:w-1/2"
        class:fixed={isFullscreen}
        class:inset-0={isFullscreen}
        class:z-50={isFullscreen}
        class:w-screen={isFullscreen}
        class:h-screen={isFullscreen}
        class:rounded-none={isFullscreen}
        role="button"
        tabindex="0"
        on:click={handleLocationUpdate}
        on:keydown={(e: KeyboardEvent) => e.key === "Enter" && handleLocationUpdate(e)}
      >
        <div class="absolute right-4 top-4 z-10 flex gap-2">
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
      <div class="flex justify-center">
        <button
          class="group relative inline-flex items-center justify-center gap-2 rounded-xl border border-border/50 bg-background/50 px-4 py-2 text-sm font-medium text-foreground shadow-lg backdrop-blur-sm transition-all hover:border-red-500/50 hover:bg-background/90 focus:outline-none focus:ring-2 focus:ring-red-500/50 active:scale-95 sm:text-base"
        >
          <span>View More Incidents</span>
          <ArrowRight class="h-4 w-4 transition-transform group-hover:translate-x-1" />
          <div
            class="absolute -inset-px rounded-xl bg-gradient-to-r from-red-500/10 to-orange-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
          ></div>
        </button>
      </div>
    </div>

    <!-- Environmental & IoT Monitoring -->
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

        <div class="flex justify-start sm:justify-end">
          <button
            class="group relative inline-flex items-center justify-center gap-2 rounded-xl border border-border/50 bg-background/50 px-4 py-2 text-sm font-medium text-foreground shadow-lg backdrop-blur-sm transition-all hover:border-red-500/50 hover:bg-background/90 focus:outline-none focus:ring-2 focus:ring-red-500/50 active:scale-95 sm:text-base"
          >
            <span>more parameters</span>
            <ArrowRight class="h-4 w-4 transition-transform group-hover:translate-x-1" />
            <div
              class="absolute -inset-px rounded-xl bg-gradient-to-r from-red-500/10 to-orange-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
            ></div>
          </button>
        </div>

        <p class="mt-1 text-sm text-muted-foreground">
          <Badge variant="outline" class="flex w-fit items-center gap-2">
            <Clock class="h-3 w-3" />
            Updated at <span class="font-medium text-red-500">{environmentalData.lastUpdated}</span>
          </Badge>
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

        <div class="flex justify-start sm:justify-end">
          <button
            class="group relative inline-flex items-center justify-center gap-2 rounded-xl border border-border/50 bg-background/50 px-4 py-2 text-sm font-medium text-foreground shadow-lg backdrop-blur-sm transition-all hover:border-red-500/50 hover:bg-background/90 focus:outline-none focus:ring-2 focus:ring-red-500/50 active:scale-95 sm:text-base"
          >
            <span>more parameters</span>
            <ArrowRight class="h-4 w-4 transition-transform group-hover:translate-x-1" />
            <div
              class="absolute -inset-px rounded-xl bg-gradient-to-r from-red-500/10 to-orange-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
            ></div>
          </button>
        </div>

        <p class="mt-1 text-sm text-muted-foreground">
          <Badge variant="outline" class="flex w-fit items-center gap-2">
            <Clock class="h-3 w-3" />
            Synced at <span class="font-medium text-red-500">{iotData.lastSync}</span>
          </Badge>
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

      <!-- Community Support -->
      <div
        class="col-span-full h-fit rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm sm:p-6 md:col-span-2"
      >
        <div class="mb-4 flex items-center gap-2">
          <Users class="h-5 w-5 text-primary" />
          <h3 class="text-lg font-semibold sm:text-xl">Community Support</h3>
        </div>
        <div class="space-y-4">
          <p class="text-sm text-muted-foreground">
            Connect with local community members and emergency responders in your area for real-time
            updates and support.
          </p>
          <div class="flex flex-col gap-3 sm:flex-row">
            <button
              class="inline-flex items-center justify-center gap-2 rounded-lg bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
            >
              <MessageCircle class="h-4 w-4" />
              Join Regional Chat
            </button>
            <button
              class="inline-flex items-center justify-center gap-2 rounded-lg border border-border bg-background px-4 py-2 text-sm font-medium text-foreground hover:bg-accent"
            >
              <Users class="h-4 w-4" />
              View Community Updates
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Historical Incidents -->
    <div class="space-y-4 sm:space-y-6">
      <div class="flex items-center gap-3">
        <History class="h-6 w-6 text-orange-500" />
        <h3 class="text-xl font-semibold sm:text-2xl">Historical Incidents</h3>
      </div>
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {#each historicalIncidents as incident}
          <div
            class="group relative overflow-hidden rounded-xl border border-border/50 bg-background/50 p-4 backdrop-blur-sm transition-all duration-300 hover:border-orange-500/50 sm:p-6"
          >
            <div
              class="absolute -inset-px rounded-xl bg-gradient-to-r from-orange-500/10 to-red-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
            ></div>
            <div class="relative space-y-4">
              <div class="flex items-center justify-between">
                <div class="space-y-1">
                  <h4 class="text-sm font-semibold sm:text-base">{incident.location}</h4>
                  <p class="mt-1 text-sm text-muted-foreground">
                    <Badge variant="outline" class="flex w-fit items-center gap-2">
                      <Clock class="h-3 w-3" />
                      {new Date(incident.date).toLocaleDateString()}
                    </Badge>
                  </p>
                </div>
                <Badge
                  variant={incident.severity === "Critical" ? "destructive" : "outline"}
                  class="ml-2"
                >
                  {incident.severity}
                </Badge>
              </div>

              <div class="grid grid-cols-2 gap-3 text-xs sm:text-sm">
                <div class="space-y-1">
                  <p class="text-muted-foreground">Affected Area</p>
                  <p class="font-medium">{incident.area}</p>
                </div>
                <div class="space-y-1">
                  <p class="text-muted-foreground">Duration</p>
                  <p class="font-medium">{incident.duration}</p>
                </div>
                <div class="space-y-1">
                  <p class="text-muted-foreground">Property Damage</p>
                  <p class="font-medium">{incident.propertyDamage}</p>
                </div>
                <div class="space-y-1">
                  <p class="text-muted-foreground">Containment Time</p>
                  <p class="font-medium">{incident.containmentTime}</p>
                </div>
              </div>

              <p class="text-xs text-muted-foreground sm:text-sm">{incident.description}</p>

              <div class="flex items-center justify-between">
                <Badge variant="outline" class="bg-orange-500/10 text-orange-500">
                  Historical Record
                </Badge>
                <button
                  class="inline-flex items-center gap-2 text-xs text-orange-500 transition-colors hover:text-orange-400 sm:text-sm"
                >
                  View Full Report
                  <ArrowRight class="h-4 w-4" />
                </button>
              </div>
            </div>
          </div>
        {/each}
      </div>
      <div class="flex justify-center">
        <button
          class="group relative inline-flex items-center justify-center gap-2 rounded-xl border border-border/50 bg-background/50 px-4 py-2 text-sm font-medium text-foreground shadow-lg backdrop-blur-sm transition-all hover:border-orange-500/50 hover:bg-background/90 focus:outline-none focus:ring-2 focus:ring-orange-500/50 active:scale-95 sm:text-base"
        >
          <span>View More History</span>
          <ArrowRight class="h-4 w-4 transition-transform group-hover:translate-x-1" />
          <div
            class="absolute -inset-px rounded-xl bg-gradient-to-r from-orange-500/10 to-red-500/10 opacity-0 blur transition duration-300 group-hover:opacity-100"
          ></div>
        </button>
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
