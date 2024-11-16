<script lang="ts">
  import * as Menubar from "$lib/components/ui/menubar";
  import { Paintbrush } from "lucide-svelte";
  import { setMode, mode } from "mode-watcher";
</script>

<Menubar.Root class="rounded-none border-b border-none px-2 lg:px-4">
  <Menubar.Menu>
    <Menubar.Trigger class="font-bold">AURA.</Menubar.Trigger>
    <Menubar.Content>
      <Menubar.Item>About AURA.</Menubar.Item>
      <Menubar.Separator />
      <Menubar.Item>
        Settings <Menubar.Shortcut>⌘,</Menubar.Shortcut>
      </Menubar.Item>
    </Menubar.Content>
  </Menubar.Menu>
  <Menubar.Menu>
    <Menubar.Trigger class="hidden md:block">Theme</Menubar.Trigger>
    <Menubar.Content>
      <Menubar.Group>
        <Menubar.RadioGroup bind:value={$mode}>
          <Menubar.RadioItem value="dark" onclick={() => setMode("dark")}>Dark</Menubar.RadioItem>
          <Menubar.RadioItem value="light" onclick={() => setMode("light")}>
            Light
          </Menubar.RadioItem>
        </Menubar.RadioGroup>
      </Menubar.Group>
    </Menubar.Content>
  </Menubar.Menu>
</Menubar.Root>
