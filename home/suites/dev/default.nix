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
    home.packages = with pkgs; [
      # Rust
      # rustup
      bacon

      # C
      gcc
      gnumake

      # Webdev
      bun
      nodejs
      zola
      biome # Might remove if I fix my nix shell configs

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
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
