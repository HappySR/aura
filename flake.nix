{
  description = "Development environment for AURA";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          pnpm
          nodejs_23
        ];
      };
    };
}
