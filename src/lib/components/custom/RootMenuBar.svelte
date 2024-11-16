<script lang="ts">
  import { setMode, mode } from "mode-watcher";
  import * as Menubar from "$lib/components/ui/menubar";
  import { Settings, Moon, Sun, User, LogIn, UserPlus } from "lucide-svelte";
</script>

<Menubar.Root
  class="rounded-none border-b border-none bg-background/20 px-2 backdrop-blur-sm lg:px-4"
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
    >
      {#if $mode === "dark"}
        <Sun class="h-4 w-4" />
      {:else}
        <Moon class="h-4 w-4" />
      {/if}
    </Menubar.Trigger>
  </Menubar.Menu>

  <Menubar.Menu>
    <Menubar.Trigger>
      <User class="h-4 w-4" />
    </Menubar.Trigger>
    <Menubar.Content>
      <Menubar.Item>
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
    <Menubar.Trigger>
      <a href="/settings">
        <Settings class="h-4 w-4" />
      </a>
    </Menubar.Trigger>
  </Menubar.Menu>
</Menubar.Root>
