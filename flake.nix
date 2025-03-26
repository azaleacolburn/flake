{
  description = "Azalea's Computer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    potatofox = {
      url = "git+https://codeberg.org/awwpotato/PotatoFox";
      flake = false;
    };

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux"; # Default system

      forEachSystem =
        f: lib.genAttrs lib.systems.flakeExposed (system: f nixpkgs.legacyPackages.${system});

      mkSystem =
        name: cfg:
        lib.nixosSystem {
          system = cfg.system or system;
          modules = [
            ./nixos
            ./hosts/${name}
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.nixvim.nixosModules.nixvim
            ./nixvim
          ] ++ (cfg.modules or [ ]);
          specialArgs = {
            inherit name inputs;
            apple-silicon = inputs.apple-silicon;
            pkgs-unstable = import inputs.nixpkgs {
              system = cfg.system or system;
            };
          };
        };
    in
    {
      formatter = forEachSystem (pkgs: pkgs.nixfmt-rfc-style);

      nixosConfigurations = lib.mapAttrs mkSystem {
        alurya = { };
        gilarabrywn.system = "aarch64-linux";
      };

      homeConfigurations.azalea = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          { targets.genericLinux.enable = true; }
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
