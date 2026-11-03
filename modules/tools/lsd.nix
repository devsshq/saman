{
  flake.modules.homeManager.lsd = { pkgs, ... }: {
    home.packages = [ pkgs.lsd ];
  };
}
