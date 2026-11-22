{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.dev;
in
{

  options.suites.dev = {
    enable = mkEnableOption "Install development tools";
    java.enable = mkEnableOption "Install java tools (intellij)";
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        zig

        # OCaml
        ocaml
        ocamlPackages.findlib
        dune_3
        ocamlPackages.ocaml-lsp
        opam

        # Misc
        gh
        fzf

        lld
        dig
        unzip

        # Disk Burner
        caligula

        # Diff tool
        delta

        # Terminal Multiplexer
        zellij

        home-manager

        syncthing

        evil-helix
      ]
      ++ lib.optionals cfg.java.enable [ ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
