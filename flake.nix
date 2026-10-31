{
  description = "saman: DevSSH's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
  {
      nixosConfigurations.dsam = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./hardware-configuration.nix # ln -sf /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
          ./modules/system.nix
          ./modules/home.nix
          ./profiles/laptop.nix
        ];
      };
    };
}
