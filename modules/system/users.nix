{ config, inputs, ... }:
let
  inherit (config.meta) username stateVersion;
in
{
  flake.modules.nixos.users = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
      shell = pkgs.zsh;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  flake.modules.homeManager.base = {
    home.stateVersion = stateVersion;
  };
}
