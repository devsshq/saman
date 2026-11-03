{ config, inputs, ... }:
let
  inherit (config.meta) username stateVersion;
  nixos = config.flake.modules.nixos;
  hm = config.flake.modules.homeManager;
in
{
  # was nixosConfigurations.dsam; now matches networking.hostName
  flake.nixosConfigurations.saman = inputs.nixpkgs.lib.nixosSystem {
    modules = [ nixos.saman ];
  };

  flake.modules.nixos.saman = {
    imports = [ ./_hardware-configuration.nix ] ++ (with nixos; [
      # system
      nix boot networking ssh doas users
      # hardware
      graphics pipewire power
      # desktop
      sway sddm portal fonts stylix
      # shell
      zsh
      # editors
      helix
      # tools
      git gitui
      aria2 btop wl-clipboard
    ]);

    networking.hostName = "saman";
    time.timeZone = "Asia/Tehran";
    system.stateVersion = stateVersion;

    home-manager.users.${username}.imports = with hm; [
      base
      sway
      zsh starship zoxide pay-respects
      kitty
      helix
      nnn mpv ripgrep lsd bat
    ];
  };
}
