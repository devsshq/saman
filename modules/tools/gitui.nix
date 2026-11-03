{
  flake.modules.nixos.gitui = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.gitui ];
  };
}
