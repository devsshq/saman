{
  flake.modules.nixos.nnn = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nnn ];
  };
}
