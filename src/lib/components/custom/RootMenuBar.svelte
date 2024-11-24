<script lang="ts">
  import { setMode, mode } from "mode-watcher";
  import * as Menubar from "$lib/components/ui/menubar";
  import { Settings, Moon, Sun, User, LogIn, UserPlus, ChevronDown } from "lucide-svelte";
  import { Button } from "$lib/components/ui/button";
  import { slide } from "svelte/transition";
  import { quintOut } from "svelte/easing";

  let isMenuOpen = false;
  const toggleMenu = () => (isMenuOpen = !isMenuOpen);
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
          const newMode = $mode === "dark" ? "light" : "dark";
          setMode(newMode);
        }}
        class="cursor-pointer transition-all duration-200 hover:scale-[1.02] hover:rounded-lg hover:bg-background/40 hover:text-primary hover:shadow-md"
      >
        {#if $mode === "dark"}
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
  </Menubar.Root>

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
            const newMode = $mode === "dark" ? "light" : "dark";
            setMode(newMode);
          }}
        >
          {#if $mode === "dark"}
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
      </div>
    </div>
  {/if}
</div>
