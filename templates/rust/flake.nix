{
  description = "Rust dev-shell template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs }:
    let
      inherit (nixpkgs) lib;
      forEachPkgs = f: lib.forEach lib.systems.flakeExposed (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forEachPkgs (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            rustc
            cargo
            clippy
          ];
        };
      });
    };
}
