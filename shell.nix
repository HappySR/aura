let
  nixpkgs = fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable";
  pkgs = import nixpkgs { config = { }; overlays = [ ]; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    pnpm
    nodejs_23
  ];
  shellHook = "fish";
}
