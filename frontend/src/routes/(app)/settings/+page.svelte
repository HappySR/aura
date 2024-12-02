<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import {
    Settings,
    User,
    Bell,
    Shield,
    Key,
    Eye,
    Moon,
    Sun,
    Smartphone,
    Globe,
    Search,
    Clock,
    Terminal,
    Trash2,
    AlertTriangle,
    Download,
    LogOut
  } from "lucide-svelte";
  import { mode, setMode } from "mode-watcher";
  import { cn } from "$lib/utils";

  // User preferences
  let preferences = {
    theme: "dark",
    notifications: true,
    twoFactorAuth: true,
    language: "English",
    timezone: "IST",
    emailNotifications: {
      security: true,
      updates: true,
      marketing: false
    },
    mobileNotifications: {
      alerts: true,
      reminders: true,
      news: false
    }
  };

  // Available languages
  const languages = ["English", "हिंदी", "বাংলা", "தமிழ்", "తెలుగు", "ಕನ್ನಡ"];

  // Available timezones
  const timezones = ["IST (UTC+5:30)", "UTC", "EST (UTC-5)", "PST (UTC-8)", "JST (UTC+9)"];

  // Search functionality
  let searchQuery = "";
  let settingsSections: HTMLElement[];

  function filterSettings() {
    if (!settingsSections) return;

    settingsSections.forEach((section) => {
      const text = section.textContent?.toLowerCase() || "";
      const matches = text.includes(searchQuery.toLowerCase());
      section.style.display = matches ? "block" : "none";
    });
  }

  function toggleTheme() {
    const newTheme = preferences.theme === "dark" ? "light" : "dark";
    setMode(newTheme);
    preferences.theme = newTheme;
  }

  function toggleTwoFactor() {
    preferences.twoFactorAuth = !preferences.twoFactorAuth;
  }

  function handleDataExport() {
    // Implementation for data export
    console.log("Exporting user data...");
  }

  function handleAccountDeletion() {
    // Implementation for account deletion
    if (
      confirm(
        "Are you sure you want to permanently delete your account? This action cannot be undone."
      )
    ) {
      console.log("Deleting account...");
    }
  }

  function handleDataDeletion() {
    // Implementation for data deletion
    if (
      confirm(
        "Are you sure you want to permanently delete all your data? This action cannot be undone."
      )
    ) {
      console.log("Deleting all user data...");
    }
  }

  // Subscribe to mode changes
  mode.subscribe((value) => {
    if (value) {
      preferences.theme = value;
    }
  });
</script>

<div
  class="min-h-screen w-full bg-gradient-to-b from-background to-background/95 px-4 py-6 md:px-8 lg:px-12"
>
  <!-- Background Gradient -->
  <div class="absolute inset-0 flex items-center justify-center">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 blur-3xl saturate-200 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"
    ></div>
  </div>

  <div class="mx-auto max-w-7xl space-y-8">
    <!-- Header -->
    <div class="mb-16 mt-12 text-center md:mb-24">
      <div class="relative">
        <div
          class="absolute -inset-[50px] animate-[pulse_6s_ease-in-out_infinite] rounded-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 opacity-30 blur-2xl"
        ></div>
        <h1
          class={cn(
            "relative bg-gradient-to-tr from-primary via-foreground to-accent bg-clip-text pb-4 text-3xl font-bold text-transparent drop-shadow-sm",
            "sm:text-4xl md:text-5xl lg:text-6xl"
          )}
        >
          Settings
        </h1>
      </div>
      <p
        class="mx-auto mt-6 max-w-2xl text-sm leading-relaxed text-muted-foreground/80 sm:text-base md:text-lg"
      >
        Enhance your emergency preparedness through our comprehensive training modules.
      </p>
    </div>

    <!-- Search Bar -->
    <div class="relative">
      <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
        <Search class="h-5 w-5 text-muted-foreground" />
      </div>
      <input
        type="text"
        bind:value={searchQuery}
        on:input={filterSettings}
        placeholder="Search settings..."
        class="w-full rounded-lg border border-border/50 bg-background/50 py-2 pl-10 pr-4 text-sm placeholder:text-muted-foreground focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
      />
    </div>

    <!-- Settings Layout -->
    <div class="flex flex-col gap-8 lg:flex-row">
      <!-- Left Column -->
      <div class="w-full space-y-6 lg:w-2/3">
        <!-- Profile Section -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[0]}
        >
          <div class="mb-4 flex items-center gap-3">
            <User class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Profile Settings</h2>
          </div>

          <div class="grid gap-4 md:grid-cols-2">
            <div class="space-y-2">
              <label for="name" class="text-sm text-muted-foreground">Display Name</label>
              <input
                id="name"
                type="text"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                value="John Doe"
              />
            </div>

            <div class="space-y-2">
              <label for="email" class="text-sm text-muted-foreground">Email</label>
              <input
                id="email"
                type="email"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                value="john@example.com"
              />
            </div>

            <div class="space-y-2">
              <label for="phone" class="text-sm text-muted-foreground">Phone Number</label>
              <input
                id="phone"
                type="tel"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                value="+91 98765-43210"
              />
            </div>

            <div class="space-y-2">
              <label for="org" class="text-sm text-muted-foreground">Organization</label>
              <input
                id="org"
                type="text"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                value="Aurialis Technologies"
              />
            </div>
          </div>
        </div>

        <!-- Security -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[1]}
        >
          <div class="mb-4 flex items-center gap-3">
            <Shield class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Security</h2>
          </div>

          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <div class="space-y-1">
                <h3 class="font-medium">Two-Factor Authentication</h3>
                <p class="text-sm text-muted-foreground">Add an extra layer of security</p>
              </div>
              <label class="relative inline-flex cursor-pointer items-center">
                <input
                  type="checkbox"
                  class="peer sr-only"
                  bind:checked={preferences.twoFactorAuth}
                />
                <div
                  class="peer h-6 w-11 rounded-full bg-border after:absolute after:left-[2px] after:top-[2px] after:h-5 after:w-5 after:rounded-full after:bg-white after:transition-all after:content-[''] peer-checked:bg-primary peer-checked:after:translate-x-full"
                ></div>
              </label>
            </div>

            <button
              class="inline-flex items-center gap-2 rounded-lg border border-border bg-background/50 px-4 py-2 text-sm font-medium hover:bg-accent"
            >
              <Key class="h-4 w-4" />
              Change Password
            </button>

            <div class="rounded-lg border border-border/50 bg-background/20 p-4">
              <h4 class="mb-2 font-medium">Recent Login Activity</h4>
              <div class="space-y-3 text-sm text-muted-foreground">
                <div class="flex items-center gap-2">
                  <Clock class="h-4 w-4 text-primary" />
                  <p>Last login: Today at 10:30 AM IST from pts/2</p>
                </div>
                <div class="flex items-center gap-2">
                  <Globe class="h-4 w-4 text-primary" />
                  <p>IP: 103.168.xx.xx (Mumbai, India)</p>
                </div>
                <div class="flex items-center gap-2">
                  <Terminal class="h-4 w-4 text-primary" />
                  <p>Firefox 120.0.1 on Ubuntu 22.04 LTS</p>
                </div>
                <div class="flex items-center gap-2">
                  <Shield class="h-4 w-4 text-green-500" />
                  <p class="text-green-500">Session secured with 2FA</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Language & Region -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[2]}
        >
          <div class="mb-4 flex items-center gap-3">
            <Globe class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Language & Region</h2>
          </div>

          <div class="grid gap-4 md:grid-cols-2">
            <div class="space-y-2">
              <label class="text-sm text-muted-foreground" for="language">Language</label>
              <select
                id="language"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                bind:value={preferences.language}
              >
                {#each languages as language}
                  <option value={language}>{language}</option>
                {/each}
              </select>
            </div>

            <div class="space-y-2">
              <label class="text-sm text-muted-foreground" for="timezone">Timezone</label>
              <select
                id="timezone"
                class="w-full rounded-lg border border-border/50 bg-background/50 px-3 py-2"
                bind:value={preferences.timezone}
              >
                {#each timezones as timezone}
                  <option value={timezone}>{timezone}</option>
                {/each}
              </select>
            </div>
          </div>
        </div>
      </div>

      <!-- Right Column -->
      <div class="w-full space-y-6 lg:w-1/3">
        <!-- Appearance -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[3]}
        >
          <div class="mb-4 flex items-center gap-3">
            <Eye class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Appearance</h2>
          </div>

          <div class="flex items-center justify-between">
            <div class="space-y-1">
              <h3 class="font-medium">Theme</h3>
              <p class="text-sm text-muted-foreground">Select your preferred theme</p>
            </div>

            <button
              class="inline-flex items-center gap-2 rounded-lg border border-border bg-background/50 px-4 py-2 text-sm font-medium hover:bg-accent"
              on:click={toggleTheme}
            >
              {#if preferences.theme === "dark"}
                <Moon class="h-4 w-4" />
                Dark
              {:else}
                <Sun class="h-4 w-4" />
                Light
              {/if}
            </button>
          </div>
        </div>

        <!-- Notifications -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[4]}
        >
          <div class="mb-4 flex items-center gap-3">
            <Bell class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Notifications</h2>
          </div>

          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <div class="space-y-1">
                <h3 class="font-medium">Email Notifications</h3>
                <p class="text-sm text-muted-foreground">Receive email updates</p>
              </div>
              <label class="relative inline-flex cursor-pointer items-center">
                <input
                  type="checkbox"
                  class="peer sr-only"
                  bind:checked={preferences.notifications}
                />
                <div
                  class="peer h-6 w-11 rounded-full bg-border after:absolute after:left-[2px] after:top-[2px] after:h-5 after:w-5 after:rounded-full after:bg-white after:transition-all after:content-[''] peer-checked:bg-primary peer-checked:after:translate-x-full"
                ></div>
              </label>
            </div>

            <div class="flex items-center justify-between">
              <div class="space-y-1">
                <h3 class="font-medium">SMS Notifications</h3>
                <p class="text-sm text-muted-foreground">Receive SMS alerts</p>
              </div>
              <label class="relative inline-flex cursor-pointer items-center">
                <input type="checkbox" class="peer sr-only" checked />
                <div
                  class="peer h-6 w-11 rounded-full bg-border after:absolute after:left-[2px] after:top-[2px] after:h-5 after:w-5 after:rounded-full after:bg-white after:transition-all after:content-[''] peer-checked:bg-primary peer-checked:after:translate-x-full"
                ></div>
              </label>
            </div>

            <div class="flex items-center justify-between">
              <div class="space-y-1">
                <h3 class="font-medium">Browser Notifications</h3>
                <p class="text-sm text-muted-foreground">Receive browser alerts</p>
              </div>
              <label class="relative inline-flex cursor-pointer items-center">
                <input type="checkbox" class="peer sr-only" checked />
                <div
                  class="peer h-6 w-11 rounded-full bg-border after:absolute after:left-[2px] after:top-[2px] after:h-5 after:w-5 after:rounded-full after:bg-white after:transition-all after:content-[''] peer-checked:bg-primary peer-checked:after:translate-x-full"
                ></div>
              </label>
            </div>
          </div>
        </div>

        <!-- Data & Privacy -->
        <div
          class="group rounded-xl border border-border/50 bg-background/20 p-6 backdrop-blur-sm transition-all duration-300 hover:scale-[1.02] hover:border-primary/50 hover:shadow-[0_0_1rem_0.25rem_rgba(0,0,0,0.04),0_2rem_2rem_-1rem_rgba(0,0,0,0.1)]"
          bind:this={settingsSections[5]}
        >
          <div class="mb-4 flex items-center gap-3">
            <Shield class="h-5 w-5 text-primary" />
            <h2 class="text-xl font-semibold">Data & Privacy</h2>
          </div>

          <div class="space-y-4">
            <button
              class="inline-flex w-full items-center justify-between gap-2 rounded-lg border border-border bg-background/50 px-4 py-2 text-sm font-medium hover:bg-accent"
              on:click={handleDataExport}
            >
              <span class="inline-flex items-center gap-2">
                <Download class="h-4 w-4" />
                Export Data
              </span>
              <Badge variant="outline">GDPR</Badge>
            </button>
            <div
              class="space-y-4 rounded-lg border border-red-700/50 bg-red-100/50 p-4 dark:border-red-700/50 dark:bg-red-950/10"
            >
              <div class="flex items-center gap-2 text-red-700 dark:text-red-500">
                <AlertTriangle class="h-5 w-5" />
                <h3 class="font-medium">Danger Zone</h3>
              </div>

              <button
                class="inline-flex w-full items-center justify-between gap-2 rounded-lg border border-red-700 bg-red-100 px-4 py-2 text-sm font-medium text-red-700 hover:bg-red-200 dark:border-red-700 dark:bg-red-950/20 dark:text-red-500 dark:hover:bg-red-950/30"
                on:click={handleDataDeletion}
              >
                <span class="inline-flex items-center gap-2">
                  <Trash2 class="h-4 w-4" />
                  Delete My Data Permanently
                </span>
                <AlertTriangle class="h-4 w-4" />
              </button>

              <button
                class="inline-flex w-full items-center justify-between gap-2 rounded-lg border border-red-700 bg-red-100 px-4 py-2 text-sm font-medium text-red-700 hover:bg-red-200 dark:border-red-700 dark:bg-red-950/20 dark:text-red-500 dark:hover:bg-red-950/30"
                on:click={handleAccountDeletion}
              >
                <span class="inline-flex items-center gap-2">
                  <Trash2 class="h-4 w-4" />
                  Delete Account
                </span>
                <AlertTriangle class="h-4 w-4" />
              </button>

              <p class="text-xs text-muted-foreground">
                Once you delete your account or data, there is no going back. Please be certain.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Save Button -->
    <div class="flex justify-end gap-4 pt-4">
      <button
        class="inline-flex items-center justify-center gap-2 rounded-xl border border-border bg-background/50 px-6 py-2.5 text-sm font-medium text-foreground hover:bg-accent"
      >
        <LogOut class="h-4 w-4" />
        Sign Out
      </button>
      <button
        class="inline-flex items-center justify-center gap-2 rounded-xl bg-primary px-6 py-2.5 text-sm font-medium text-primary-foreground hover:bg-primary/90"
      >
        <Settings class="h-4 w-4" />
        Save Changes
      </button>
    </div>
  </div>
</div>
