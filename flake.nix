{
  description = "Azalea's Computer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems = {
      url = ./systems.nix;
      flake = false;
    };

    # keep-sorted start block=yes newline_separated=yes
    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
        nuschtosSearch.follows = "";
      };
    };

    potatofox = {
      url = "git+https://codeberg.org/awwpotato/potatofox";
      flake = false;
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        home-manager.follows = "home-manager";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "";
      };
    };
    # keep-sorted end
  };

  outputs =
    inputs@{
      flake-parts,
      systems,
      nixpkgs,
      home-manager,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      {
        systems = import systems;

        perSystem =
          { pkgs, ... }:
          {
            formatter = pkgs.treefmt.withConfig {
              runtimeInputs = with pkgs; [
                nixfmt-rfc-style
                keep-sorted
              ];

              settings = {
                on-unmatched = "info";
                tree-root-file = "flake.nix";

                formatter = {
                  nixfmt = {
                    command = "nixfmt";
                    includes = [ "*.nix" ];
                  };
                  keep-sorted = {
                    command = "keep-sorted";
                    includes = [ "*" ];
                  };
                };
              };
            };
          };

        flake =
          let
            system = "x86_64-linux"; # Default system

            mkSystem =
              name: cfg:
              lib.nixosSystem {
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
                  inherit (inputs) apple-silicon;
                };
              };
          in
          {
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
    );
}
