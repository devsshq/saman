{
  flake.modules.nixos.power = {
    services.logind.settings.Login.HandleLidSwitch = "hibernate";
    services.upower.enable = true;
  };
}
