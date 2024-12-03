{
  description = "Development shell for AURA";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          pnpm
          nodejs_23
        ];
      };
    };
}
