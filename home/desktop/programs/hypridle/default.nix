{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.services.hypridle;
in {
  services.hypridle.settings = mkIf cfg.enable {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
      ignore_dbus_inhibit = false;
    };

    listener = [
      {
        timeout = 300;
        on-timeout = "loginctl lock-session"; # lock screen.
      }

      {
        timeout = 330;
        on-timeout = "hyprctl dispatch dpms off"; # turn off display.
        on-resume = "hyprctl dispatch dpms on"; # turn on display.
      }

      {
        timeout = 600;
        on-timeout = "systemctl suspend"; # suspend.
      }
    ];
  };
}
