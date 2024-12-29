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
      gh
      cargo
      python3
      hugo
      (mkIf cfg.java.enable jetbrains.idea-community)
    ];

    programs = {
      # firefox.enable = true;
    };
  };
}
