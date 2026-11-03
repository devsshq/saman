{
  flake.modules.homeManager.nnn = { pkgs, ... }: {
    home.packages = [ pkgs.nnn ];
  };
}
