{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.stylix.fonts) monospace;
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (lib) mkIf mkForce;
  inherit (config.homeConf) radius;
  cfg = config.programs.rofi;
  mkRgba = opacity: color: let
    c = config.lib.stylix.colors;
    r = c."${color}-rgb-r";
    g = c."${color}-rgb-g";
    b = c."${color}-rgb-b";
  in
    mkLiteral
    "rgba ( ${r}, ${g}, ${b}, ${opacity} % )";
in {
  programs.rofi = mkIf cfg.enable {
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji-wayland
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = mkForce "${monospace.name} 16";
    extraConfig = {
      modi = "drun,emoji";
      show-icons = true;
      display-drun = " ";
      display-window = "󰩉 ";
      display-emoji = "󰞅 ";
    };
    theme = {
      "*" = {
        background-color = mkForce (mkLiteral "transparent");
        lightbg = mkForce (mkRgba (builtins.toString 20) "base01");
      };
      window = {
        width = mkLiteral "500px";
        border-radius = radius * 2;
      };
      mainbox = {
        children = ["inputbar" "message" "listview" "mode-switcher"];
        border-radius = radius * 2;
        padding = mkLiteral "8px";
      };
      listbox = {
        spacing = mkLiteral "4px";
        border-radius = radius;
      };
      inputbar = {
        border-radius = radius;
        children = ["prompt" "entry"];
        background-color = mkLiteral "transparent";
        margin = mkLiteral "0 0 4px 0";
        padding = mkLiteral "4px";
      };
      mode-switcher = {
        spacing = 10;
      };
      button = {
        border-radius = radius;
      };
      listview = {
        spacing = mkLiteral "8px";
        dynamic = true;
        border-radius = radius;
      };
      element = {
        padding = mkLiteral "2px";
        border-radius = radius;
      };
      element-text.background-color = mkForce (mkLiteral "transparent");
      element-icon = {
        background-color = mkForce (mkLiteral "transparent");
        size = mkLiteral "28px";
      };
      "element normal.normal".background-color = mkForce (mkLiteral "transparent");
      "element alternate.normal".background-color = mkForce (mkLiteral "transparent");
    };
  };
}
