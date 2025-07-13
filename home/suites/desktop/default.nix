{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.desktop;
in
{
  options.suites.desktop = {
    enable = mkEnableOption "Install a wm/de + apps for desktop usage";
    hyprland.enable = mkEnableOption "Install hyprland + apps for desktop usage";
    slack.enable = mkEnableOption "Install slack (no aarch64-linux version)";
    spotify.enable = mkEnableOption "Install spotify (no aarch64-linux version)";
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
      ghostty.enable = true;
      # btop replacement
      bottom.enable = true;
      yazi.enable = true;
      fastfetch = {
        enable = true;
        settings = {
          logo = {
            # source = "~/flake/media/fetch/trans_nix.png";
          };
          modules = [
            "title"
            "separator"
            "os"
            # "kernel"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "display"
            "de"
            "wm"
            # "wmtheme"
            # "icons"
            "terminal"
            "cpu"
            "gpu"
            "memory"
            "colors"
          ];
        };
      };
    };

    home.packages =
      with pkgs;
      [
        fastfetch

        ffmpeg
        imagemagick
        cava
        appimage-run
        signal-desktop
      ]
      ++ (if cfg.slack.enable then [ slack ] else [ ])
      ++ (if cfg.spotify.enable then [ spotify ] else [ ncspot ]);

    gtk.iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
