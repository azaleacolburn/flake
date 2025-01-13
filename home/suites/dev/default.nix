{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.dev;
in {
  options.suites.dev = {
    enable =
      mkEnableOption "Install development tools";
    java.enable =
      mkEnableOption "Install java tools (intellij)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cargo
      rustc

      gcc

      bun
      nodejs

      python3

      gh # Github CLI (used for auth)
      zola # Static Site Renderer

      fzf # Fuzzy Finder
    ];

    programs = {
    };
  };
}
