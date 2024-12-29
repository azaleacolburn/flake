{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.media;
in {
  options.suites.media.enable =
    mkEnableOption "Install programs for media viewing/editing usage";

  config = mkIf cfg.enable {
    programs = {
      yt-dlp.enable = true;
    };

    home.packages = with pkgs; [
      gimp
      # footage
      libreoffice
      obs-studio
      vlc
      inkscape
    ];
  };
}
