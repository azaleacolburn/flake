{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.gaming;
in
{
  options.suites.gaming.enable = mkEnableOption "Install steam + other gaming stuff";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lutris
      prismlauncher
      # Home manager doesn't play nice with programs
      steam
    ];
  };
}
