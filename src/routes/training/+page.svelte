<script lang="ts">
  import { Badge } from "$lib/components/ui/badge";
  import {
    BookOpen,
    ArrowRight,
    Shield,
    Activity,
    Users,
    Mail,
    Phone,
    MapPin,
    Github,
    Twitter,
    Linkedin
  } from "lucide-svelte";
  import { cn } from "$lib/utils";

  const trainingModules = [
    {
      icon: Shield,
      title: "Emergency Response",
      description:
        "Learn fundamental emergency response protocols and best practices for different disaster scenarios.",
      duration: "2 hours",
      level: "Beginner"
    },
    {
      icon: Activity,
      title: "First Aid & Medical",
      description: "Essential first aid techniques and medical emergency handling procedures.",
      duration: "3 hours",
      level: "Intermediate"
    },
    {
      icon: Users,
      title: "Community Coordination",
      description:
        "Strategies for effective community organization and coordination during emergencies.",
      duration: "1.5 hours",
      level: "Beginner"
    },
    {
      icon: BookOpen,
      title: "Disaster Preparedness",
      description:
        "Comprehensive preparation guides for different types of natural and man-made disasters.",
      duration: "4 hours",
      level: "Advanced"
    }
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
</script>

<div
  class="animate-fade-in relative flex min-h-[100vh] w-full flex-col items-center justify-center overflow-hidden bg-inherit px-4"
>
  <!-- Background Gradient -->
  <div class="absolute inset-0 flex items-center justify-center">
    <div
      class="absolute h-full w-full bg-gradient-to-r from-primary/10 via-accent/10 to-primary/10 blur-3xl saturate-200 [mask-image:radial-gradient(ellipse_at_center,transparent_20%,black)]"
    ></div>
  </div>

  <div class="relative z-10 mx-auto w-full max-w-7xl px-4 py-16 sm:px-6 md:py-24 lg:px-8">
    <!-- Header Section -->
    <div class="mb-16 text-center md:mb-24">
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
          Training & Preparedness
        </h1>
      </div>
      <p
        class="mx-auto mt-6 max-w-2xl text-sm leading-relaxed text-muted-foreground/80 sm:text-base md:text-lg"
      >
        Enhance your emergency preparedness through our comprehensive training modules.
      </p>
    </div>

    <!-- Training Modules Grid -->
    <div class="relative grid grid-cols-1 gap-8 px-4 py-8 md:grid-cols-2 md:p-8">
      <div
        class="absolute inset-0 rounded-3xl bg-gradient-to-r from-primary/15 via-accent/15 to-primary/15 blur-3xl"
      ></div>
      {#each trainingModules as module}
        <div
          class={cn(
            "group rounded-2xl border border-border/30 bg-background/40 p-6 backdrop-blur-xl transition-all duration-300",
            "hover:-translate-y-2 hover:border-border/50 hover:shadow-lg md:p-8"
          )}
        >
          <div
            class="mb-6 flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 transition-transform duration-300 group-hover:scale-110"
          >
            <svelte:component this={module.icon} class="h-6 w-6 text-primary" />
          </div>

          <div class="mb-3">
            <h3 class="text-xl font-semibold">{module.title}</h3>
            <div class="mt-2 flex gap-2">
              <Badge variant="outline" class="text-xs">{module.duration}</Badge>
              <Badge variant="outline" class="text-xs">{module.level}</Badge>
            </div>
          </div>

          <p class="text-muted-foreground/70">{module.description}</p>

          <button
            class="mt-4 inline-flex items-center gap-2 text-sm text-primary opacity-70 transition-all duration-300 hover:underline hover:opacity-100"
          >
            Start Training
            <ArrowRight
              class="h-4 w-4 transition-transform duration-300 group-hover:translate-x-1"
            />
          </button>
        </div>
      {/each}
    </div>

    <!-- Footer -->
    <footer class="relative mt-24 w-full bg-background/80 backdrop-blur-xl">
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
