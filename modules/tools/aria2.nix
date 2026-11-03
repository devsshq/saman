{
  flake.modules.nixos.aria2 = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.aria2 ];
  };
}
