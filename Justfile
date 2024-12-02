default:
  @just --list

pnpm ARGS:
  @cd frontend && pnpm {{ARGS}}

alias c-up := compose-up
compose-up:
  @docker compose up -d

alias c-down := compose-down
compose-down:
  @docker compose down

alias dev := dev-shell
dev-shell:
  @nix-shell
