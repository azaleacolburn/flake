{
  lib,
  config,
  ...
}:
let
  cfg = config.programs.waybar;
  fonts = config.stylix.fonts;
in
{
  stylix.targets.waybar.addCss = false;
  programs.waybar = lib.mkIf cfg.enable {
    style = ''
      window#waybar {
        background: alpha(@base00, 0.6);
      }

      * {
        font-family: ${fonts.monospace.name};
        font-size: ${toString fonts.sizes.desktop}px;
      }
    ''
    + (builtins.readFile ./style.css);
    settings.mainBar = {
      layer = "top";
      position = "top";
      mode = "dock";
      margin-top = 5;
      margin-left = 10;
      margin-right = 10;
      reload_style_on_change = true;
      spacing = 5;
      modules-left = [
        "clock"
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [ ];
      modules-right = [
        "tray"
        "cpu"
        "memory"
        "network"
        "bluetooth"
        "pulseaudio"
        "backlight"
        "power-profiles-daemon"
        "battery"
        "idle_inhibitor"
        # "custom/power"
      ];
      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        disable-scroll = true;
        on-click = "activate";
      };
      clock = {
        format = "{:%H:%M %b %d}";
      };
      battery = {
        states = {
          warning = 20;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = " {capacity}%";
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      backlight = {
        format = "󰛩 {percent}%";
        states = {
          on = 1;
          off = 0;
        };
        format-off = "󰹐 {percent}%";
      };
      network = {
        tooltip = false;
        format-wifi = "󰖩 {essid}";
        format-disconnected = "󰖪";
        format-ethernet = "󰈀";
      };
      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "󰖁  {volume}%";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          phone-muted = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };
      };
      bluetooth = {
        format = "";
        format-off = "󰂲";
        format-connected = "󰂱";
        on-click-right = "bluetoothctl disconnect";
      };
      disk = {
        interval = 300;
        format = "󰋊 {used}";
        path = "/";
      };
      memory = {
        format = " {used}GiB";
      };
      cpu = {
        interval = 1;
        format = " {usage}%";
        max-length = 10;
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip = true;
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        format-icons = {
          default = "";
          performance = "";
          balanced = " ";
          power-saver = " ";
        };
      };
      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "wlogout";
      };
      tray = {
        spacing = 5;
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰒳";
          deactivated = "󰒲";
        };
      };
    };
  };
}
