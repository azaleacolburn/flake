{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.host.im;
in {
  options.host.im.fcitx5 = {
    enable = mkEnableOption "enable fcitx5 for chinese input";
    wayland = mkEnableOption "fix fcitx5 on wayland";
  };

  config.i18n.inputMethod = mkIf cfg.fcitx5.enable {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = cfg.fcitx5.wayland;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-chinese-addons
        fcitx5-catppuccin
        fcitx5-tokyonight
        fcitx5-nord
      ];
    };
  };
}
