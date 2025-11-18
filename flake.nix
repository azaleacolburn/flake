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
      url = "git+https://codeberg.org/da157/potatofox";
      flake = false;
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };

    zen-browser.url = "git+https://codeberg.org/0x57e11a/flake-zen";

    porcelain.url = "https://codeberg.org/da157/porcelain/archive/main.tar.gz";
    # keep-sorted end
  };

  outputs =
    inputs@{
      flake-parts,
      systems,
      nixpkgs,
      home-manager,
      rust-overlay,
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

        flake = {
          nixosConfigurations =
            lib.genAttrs
              [
                "alurya"
                "esrahaddon"
                "gilarabrywn"
              ]
              (
                name:
                lib.nixosSystem {
                  modules = [
                    # keep-sorted start prefix_order=inputs,./
                    inputs.home-manager.nixosModules.home-manager
                    inputs.nixvim.nixosModules.nixvim
                    inputs.stylix.nixosModules.stylix
                    ./hosts/${name}
                    ./nixos
                    ./nixvim
                    (
                      { pkgs, ... }:
                      {
                        nixpkgs.overlays = [ rust-overlay.overlays.default ];
                        environment.systemPackages = [
                          pkgs.rust-bin.stable.latest.default
                          inputs.porcelain.packages.${pkgs.stdenv.hostPlatform.system}.porcelain
                        ];
                      }
                    )
                    # keep-sorted end
                  ];
                  specialArgs = {
                    inherit name inputs;
                    inherit (inputs) apple-silicon;
                  };
                }
              );

          homeConfigurations.azalea = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            modules = [
              # keep-sorted start prefix_order=inputs,./,{
              inputs.nixvim.homeManagerModules.nixvim
              inputs.stylix.homeManagerModules.stylix
              inputs.zen-browser.packages."x86_64-linux".default
              ./home
              ./nixos/homeConf/shared.nix
              ./nixos/stylix/hm.nix
              ./nixos/stylix/shared.nix
              ./nixvim
              { targets.genericLinux.enable = true; }
              # keep-sorted end
            ];
          };
        };
      }
    );
}
