{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.lib.stylix.colors) base00 base0D base05 base08 base0A base0C base0B;
  inherit (config) homeConf;
  cfg = config.programs.hyprlock;
  font_family = config.stylix.fonts.monospace.name;
  battery = pkgs.writeShellScript "battery" ''
    bat=$(ls /sys/class/power_supply | grep BAT | head -1 | grep -Eo '^[^ ]+')
    [ "$bat" ] || exit 1;
    battery_percentage=$(cat /sys/class/power_supply/$bat/capacity)
    battery_status=$(cat /sys/class/power_supply/$bat/status)
    battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
    charging_icon="󰂄"
    icon_index=$((battery_percentage / 10))

    battery_icon=${"$" + "{battery_icons[icon_index]}"}

    [ "$battery_status" = "Charging" ] &&
        battery_icon="$charging_icon"

    echo "$battery_icon $battery_percentage%"
  '';
in {
  programs.hyprlock.settings = lib.mkIf cfg.enable {
    general = {
      disable_loading_bar = true;
      hide_cursor = true;
      enable_fingerprint = true;
    };

    background = [
      {
        path = "${homeConf.wallpaper}";
        blur_passes = 2;
        blur_size = 3;
        color = "rgb(${base00})";
      }
    ];

    label = [
      {
        inherit font_family;
        text = "cmd[update:30000] echo \"$(date +\"%I:%M\")\"";
        color = "rgb(${base05})";
        font_size = 90;
        position = "0, 150";
        halign = "center";
        valign = "center";
      }
      {
        inherit font_family;
        text = "cmd[update:43200000] echo \"$(date +\"%a, %d %B %Y\")\"";
        color = "rgb(${base05})";
        font_size = 25;
        position = "0, 50";
        halign = "center";
        valign = "center";
      }
      {
        inherit font_family;
        text = "cmd[update:1000] echo \"$(${battery})\"";
        color = "rgb(${base0B})";
        font_size = 16;
        position = "20, 20";
        halign = "left";
        valign = "bottom";
      }
    ];

    input-field = [
      {
        inherit font_family;
        size = "300, 60";
        outline_thickness = 2;
        rounding = 10;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        font_color = "rgb(${base05})";
        outer_color = "rgba(${base0D}99)";
        inner_color = "rgba(${base00}99)";
        check_color = "rgba(${base0C}99)";
        fail_color = "rgba(${base08})";
        capslock_color = "rgba(${base0A})";
        fade_on_empty = false;
        placeholder_text = "<i>󰌾 Logged in as $USER</i>";
        hide_input = false;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        position = "0, 20";
        halign = "center";
        valign = "bottom";
      }
    ];
  };
}
