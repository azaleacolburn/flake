{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.desktop;
in {
  options.suites.desktop = {
    enable = mkEnableOption "Install a wm/de + apps for desktop usage";
    hyprland.enable = mkEnableOption "Install hyprland + apps for desktop usage";
  };

  config = mkIf cfg.enable {
    desktop = {
      hyprland = {
        enable = mkIf cfg.hyprland.enable true;
      };
    };

    xdg.mimeApps.enable = true;

    programs = {
      librewolf = {
        enable = true;
        default = true;
      };
      alacritty.enable = true;
    };

    home.packages = with pkgs; [
      # slack
      # spotify
      neofetch

      ffmpeg
      imagemagick
      cava
      appimage-run
    ];

    gtk.iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
