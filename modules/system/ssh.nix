{
  flake.modules.nixos.ssh = {
    services.sshd.enable = true;
  };
}
