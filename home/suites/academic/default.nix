{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.academic;
in
{
  options.suites.academic.enable = mkEnableOption "Install academic tools";

  config = mkIf cfg.enable {
    programs = {
    };

    home.packages = with pkgs; [
      numbat
      chromium

      kiwix
    ];
  };
}
