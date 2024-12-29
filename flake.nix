{
  description = "Azalea's Computer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix/release-24.11";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    potatofox = {
      url = "git+https://codeberg.org/awwpotato/PotatoFox";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations.garden = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/alurya
        ./nixos
        home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.nixvim.nixosModules.nixvim
        ./nixvim
      ];
      specialArgs = {
        inherit inputs;
        name = "garden";
        pkgs-unstable = import inputs.nixpkgs {
          inherit system;
          allowUnfree = true;
        };
      };
    };
    homeConfigurations.azalea = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        {targets.genericLinux.enable = true;}
        inputs/stylix.homeManagerModules.stylix
        inputs/nixvim.homeManagerModules.nixvim
        ./nixvim
        ./home
        ./nixos/homeConf/shared.nix
        ./nixos/stylix/hm.nix
        ./nixos/stylix/shared.nix
      ];
    };
  };
}
