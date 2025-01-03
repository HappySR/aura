{ pkgs, ... }:

{
  dotenv.enable = true;
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs_23;
    pnpm.enable = true;
  };
}
