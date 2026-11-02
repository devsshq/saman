{
  description = "saman: DevSSH's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs:
  {
      nixosConfigurations.dsam = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ./hardware-configuration.nix # ln -sf /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix
          ./modules/system.nix
          ./modules/home.nix
          ./modules/theme.nix
          ./profiles/laptop.nix
        ];
      };
    };
}
