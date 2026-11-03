{
  flake.modules.nixos.doas = {
    security.sudo.enable = false;
    security.doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        persist = true;
        keepEnv = true;
      }];
    };
  };
}
