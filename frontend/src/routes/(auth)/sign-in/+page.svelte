<script lang="ts">
  import { Button } from "$lib/components/ui/button";
  import { Input } from "$lib/components/ui/input";
  import { Label } from "$lib/components/ui/label";
  import { Mail, Lock, ArrowRight, Eye, EyeOff, ArrowLeft } from "lucide-svelte";
  import { cn } from "$lib/utils";

  let showPassword = false;
</script>

<div
  class="animate-fade-in relative flex min-h-[100vh] w-full flex-col items-center justify-center overflow-hidden bg-inherit px-4"
>
  <!-- Background Gradient -->
  <div class="absolute inset-0 flex items-center justify-center">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 to-accent/10 blur-2xl saturate-200 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"
    ></div>
  </div>

  <div class="relative z-10 w-full max-w-md space-y-8">
    <div class="text-center">
      <h1
        class="animate-fade-up bg-gradient-to-tr from-primary via-foreground to-accent bg-clip-text text-4xl font-extrabold tracking-tight text-transparent drop-shadow-sm"
      >
        Welcome Back<span class="text-primary">.</span>
      </h1>
      <p class="animate-fade-up mt-4 text-lg text-muted-foreground/70">
        Sign in to continue to your dashboard
      </p>
    </div>

    <div class="animate-fade-up">
      <div
        class="absolute inset-0 rounded-3xl bg-gradient-to-r from-primary/15 via-accent/15 to-primary/15 blur-3xl"
      ></div>

      <form
        class={cn(
          "group rounded-2xl border border-border/30 bg-background/40 p-6 backdrop-blur-xl transition-all duration-300",
          "hover:-translate-y-2 hover:border-border/50 hover:shadow-lg md:p-8"
        )}
      >
        <div class="space-y-2">
          <Label for="email">Email</Label>
          <div class="relative">
            <Mail class="absolute left-3 top-[0.6rem] h-5 w-5 text-muted-foreground/50" />
            <Input type="email" id="email" placeholder="name@example.com" class="pl-10" />
          </div>
        </div>

        <div class="mt-4 space-y-2">
          <Label for="password">Password</Label>
          <div class="relative">
            <Lock class="absolute left-3 top-[0.6rem] h-5 w-5 text-muted-foreground/50" />
            <Input
              type={showPassword ? "text" : "password"}
              id="password"
              placeholder="••••••••"
              class="pl-10 pr-10"
            />
            <button
              type="button"
              class="absolute right-3 top-[0.6rem] text-muted-foreground/50 hover:text-muted-foreground"
              on:click={() => (showPassword = !showPassword)}
            >
              {#if showPassword}
                <EyeOff class="h-5 w-5" />
              {:else}
                <Eye class="h-5 w-5" />
              {/if}
            </button>
          </div>
        </div>

        <div
          class="mt-6 flex flex-col space-y-4 text-sm text-muted-foreground/70 sm:flex-row sm:items-center sm:justify-between sm:space-y-0"
        >
          <a
            href="/forgot-password"
            class="text-primary transition-colors hover:text-primary/80 hover:underline"
          >
            Forgot your password?
          </a>
        </div>

        <Button type="submit" class="group mt-6 w-full">
          Sign In
          <ArrowRight
            class="ml-2 h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
          />
        </Button>

        <div class="mt-5 flex items-center justify-between text-sm text-muted-foreground/70">
          <div class="flex items-center space-x-2">
            <span>Don't have an account?</span>
            <a
              href="/sign-up"
              class="font-medium text-primary transition-colors hover:text-primary/80 hover:underline"
            >
              Sign Up!
            </a>
          </div>
        </div>

        <div
          class="mt-6 flex flex-col space-y-4 text-sm text-muted-foreground/70 sm:flex-row sm:items-center sm:justify-between sm:space-y-0"
        >
          <a
            href="/"
            class="group flex items-center font-medium text-primary transition-colors hover:text-primary/80 hover:underline"
          >
            <ArrowLeft
              class="mr-2 h-4 w-4 transition-transform duration-300 group-hover:-translate-x-1"
            />
            Home
          </a>
        </div>
      </form>
    </div>
  </div>
</div>
