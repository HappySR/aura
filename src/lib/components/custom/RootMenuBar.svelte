<script lang="ts">
  import { goto } from "$app/navigation";
  import { Home, Settings, Moon, Sun, Paintbrush, User, LogIn, UserPlus } from "lucide-svelte";
  import { setMode, mode } from "mode-watcher";
  import * as Menubar from "$lib/components/ui/menubar";
</script>

<Menubar.Root class="rounded-none border-b border-none px-2 lg:px-4">
  <Menubar.Menu>
    <Menubar.Trigger class="font-bold" onclick={() => goto("/")}>AURA.</Menubar.Trigger>
  </Menubar.Menu>

  <Menubar.Menu>
    <Menubar.Trigger
      class="hidden md:block"
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
    </Menubar.Trigger>
  </Menubar.Menu>

  <Menubar.Menu>
    <Menubar.Trigger class="hidden md:block">
      <User class="h-4 w-4" />
    </Menubar.Trigger>
    <Menubar.Content>
      <Menubar.Item onclick={() => goto("/")}>
        <UserPlus class="mr-2 h-4 w-4" />
        Sign Up
      </Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item>
        <LogIn class="mr-2 h-4 w-4" />
        Sign In
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>

  <Menubar.Menu>
    <Menubar.Trigger class="hidden md:block" onclick={() => goto("/settings")}>
      <Settings class="h-4 w-4" />
    </Menubar.Trigger>
  </Menubar.Menu>
</Menubar.Root>
