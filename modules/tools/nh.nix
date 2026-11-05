{ config, ... }:
let
  inherit (config.meta) username;
in
{
  flake.modules.nixos.nh = {
    programs.nh = {
      enable = true;
      flake = "/home/${username}/saman";
    };
  };
}
