{
  flake.modules.homeManager.v2rayn = { pkgs, ... }: {
    home.packages = [ pkgs.v2rayn ];
  };
}
