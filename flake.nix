{
  description = "Azalea's Computer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11"; # For if I need stable

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    potatofox = {
      url = "git+https://codeberg.org/awwpotato/PotatoFox";
      flake = false;
    };

    apple-silicon = {
      url = "github:azaleacolburn/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux"; # Default system

    mkSystem = name: cfg:
      lib.nixosSystem {
        system = cfg.system or system;
        modules =
          [
            ./nixos
            ./hosts/${name}
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nixvim.nixosModules.nixvim
            ./nixvim
          ]
          ++ (cfg.modules or []);
        specialArgs = {
          inherit name inputs;
          apple-silicon = inputs.apple-silicon;
          pkgs-unstable = import inputs.nixpkgs {
            system = cfg.system or system;
          };
        };
      };
  in {
    nixosConfigurations = lib.mapAttrs mkSystem {
      alurya = {};
      gilarabrywn = {
        system = "aarch64-linux";
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
