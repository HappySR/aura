<script lang="ts">
  import { setMode, mode } from "mode-watcher";
  import * as Menubar from "$lib/components/ui/menubar";
  import { Settings, Moon, Sun, User, LogIn, UserPlus, ChevronDown } from "lucide-svelte";
  import { Button } from "$lib/components/ui/button";
  import { slide, scale } from "svelte/transition";
  import { quintOut } from "svelte/easing";

  let isMenuOpen = false;
  let isSearchOpen = false; // Added missing variable declaration
  let searchQuery = ""; // Added missing variable declaration

  const toggleMenu = () => (isMenuOpen = !isMenuOpen);
  const toggleSearch = () => (isSearchOpen = !isSearchOpen); // Added missing toggle function

  const performSearch = () => {
    console.log("Search performed with query:", searchQuery); // Placeholder logic for search
  };
</script>

<div class="fixed top-0 z-50 w-full">
  <!-- Desktop Menu -->
  <Menubar.Root
    class="hidden rounded-none border-b border-none bg-background/20 px-2 backdrop-blur-sm md:flex lg:px-4"
  >
    <Menubar.Menu>
      <Menubar.Trigger class="font-bold">
        <a href="/">AURA.</a>
      </Menubar.Trigger>
    </Menubar.Menu>

    <Menubar.Menu>
      <Menubar.Trigger
        onclick={() => {
          const newMode = $mode === "dark" ? "light" : "dark"; // Fixed reactive store access
          setMode(newMode);
        }}
        class="cursor-pointer transition-all duration-200 hover:scale-[1.02] hover:rounded-lg hover:bg-background/40 hover:text-primary hover:shadow-md"
      >
        {#if $mode === "dark"} <!-- Fixed reactive store access -->
          <Sun class="h-4 w-4" />
        {:else}
          <Moon class="h-4 w-4" />
        {/if}
      </Menubar.Trigger>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger
        class="cursor-pointer transition-all duration-200 hover:scale-[1.02] hover:rounded-lg hover:bg-background/40 hover:text-primary hover:shadow-md"
      >
        <User class="h-4 w-4" />
      </Menubar.Trigger>
      <Menubar.Content class="border border-border/50 bg-background/30 backdrop-blur-sm">
        <Menubar.Item class="hover:bg-background/40 hover:text-primary">
          <UserPlus class="mr-2 h-4 w-4" />
          Sign Up
        </Menubar.Item>
        <Menubar.Separator />
        <Menubar.Item class="hover:bg-background/40 hover:text-primary">
          <LogIn class="mr-2 h-4 w-4" />
          Sign In
        </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>

    <Menubar.Menu>
      <Menubar.Trigger
        class="cursor-pointer transition-all duration-200 hover:scale-[1.02] hover:rounded-lg hover:bg-background/40 hover:text-primary hover:shadow-md"
      >
        <a href="/settings">
          <Settings class="h-4 w-4" />
        </a>
      </Menubar.Trigger>
    </Menubar.Menu>

  <!-- Explore Now -->
  <Menubar.Menu>
    <Menubar.Trigger
      onclick={toggleSearch}
      class="cursor-pointer transition-all duration-200 hover:scale-[1.02] hover:rounded-lg hover:bg-background/40 hover:text-primary hover:shadow-md"
    >
      Explore Now
    </Menubar.Trigger>
  </Menubar.Menu>
</Menubar.Root>

  <!-- Search Bar -->
  {#if isSearchOpen}
    <button
      class="fixed inset-0 z-40 bg-black/50"
      on:click={toggleSearch}
      aria-label="Close search"
      type="button"
    ></button>

    <div
      class="fixed top-0 left-1/2 z-50 w-full max-w-3xl -translate-x-1/2 rounded-lg bg-transparent shadow-xl"
      transition:scale={{ duration: 300 }}
    >
      <div class="relative flex items-center px-4 py-3">
        <input
          type="text"
          bind:value={searchQuery}
          placeholder="Type to search..."
          class="w-full rounded-lg border border-gray-300 p-3 text-sm focus:outline-none focus:ring focus:ring-blue-300"
          on:keydown={(e) => e.key === "Enter" && performSearch()}
        />
        <button
          class="absolute right-4 bg-blue-500 px-4 py-2 text-white rounded-md hover:bg-blue-600"
          on:click={performSearch}
        >
          Search
        </button>
      </div>
    </div>
  {/if}

  <!-- Mobile Menu -->
  <div
    class="flex items-center justify-between bg-background/20 px-4 py-2 backdrop-blur-sm md:hidden"
  >
    <a href="/" class="font-bold">AURA.</a>

    <Button variant="ghost" size="icon" onclick={toggleMenu}>
      <ChevronDown
        class="h-5 w-5 transition-transform duration-200 {isMenuOpen ? 'rotate-180' : ''}"
      />
    </Button>
  </div>

  {#if isMenuOpen}
    <div
      class="absolute left-0 top-full w-full space-y-4 border-b bg-background/20 p-4 shadow-lg backdrop-blur-sm md:hidden"
      transition:slide={{ duration: 200, easing: quintOut }}
    >
      <div class="grid grid-cols-2 gap-3">
        <Button
          variant="ghost"
          class="flex items-center space-x-2 rounded-lg border border-border/50 bg-background/30 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02] hover:bg-background/40 hover:text-primary hover:shadow-md"
          onclick={() => {
            const newMode = $mode === "dark" ? "light" : "dark"; // Fixed reactive store access
            setMode(newMode);
          }}
        >
          {#if $mode === "dark"} <!-- Fixed reactive store access -->
            <Sun class="h-4 w-4" />
          {:else}
            <Moon class="h-4 w-4" />
          {/if}
          <span>Theme</span>
        </Button>
        <Button
          variant="ghost"
          href="/settings"
          class="flex items-center space-x-2 rounded-lg border border-border/50 bg-background/30 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02] hover:bg-background/40 hover:text-primary hover:shadow-md"
        >
          <Settings class="h-4 w-4" />
          <span>Settings</span>
        </Button>
        <Button
          variant="ghost"
          href="/signup"
          class="flex items-center space-x-2 rounded-lg border border-border/50 bg-background/30 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02] hover:bg-background/40 hover:text-primary hover:shadow-md"
        >
          <UserPlus class="h-4 w-4" />
          <span>Sign Up</span>
        </Button>
        <Button
          variant="ghost"
          href="/signin"
          class="flex items-center space-x-2 rounded-lg border border-border/50 bg-background/30 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02] hover:bg-background/40 hover:text-primary hover:shadow-md"
        >
          <LogIn class="h-4 w-4" />
          <span>Sign In</span>
        </Button>
        <Button
          variant="ghost"
          class="flex items-center space-x-2 rounded-lg border border-border/50 bg-background/30 backdrop-blur-sm transition-all duration-200 hover:scale-[1.02] hover:bg-background/40 hover:text-primary hover:shadow-md"
          onclick={() => {
            const newMode = $mode === "dark" ? "light" : "dark"; // Fixed reactive store access
            setMode(newMode);
          }}
        >
          {#if $mode === "dark"} <!-- Fixed reactive store access -->
            <Sun class="h-4 w-4" />
          {:else}
            <Moon class="h-4 w-4" />
          {/if}
          <span>Explore Now</span>
        </Button>
      </div>
    </div>
  {/if}
</div>

