{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption optionals;
  inherit (config) homeConf;
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland.enable = mkEnableOption "Enable hyprland desktop";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
      wl-clipboard-rs
      swappy
      grimblast
    ];

    programs = {
      rofi.enable = true;
      waybar.enable = true;
      hyprlock.enable = true;
      wlogout.enable = true;
    };

    services = {
      hyprpaper.enable = true;
      hypridle.enable = true;
      dunst.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      settings = {
        debug = {
          disable_logs = false;
        };
        exec-once = [
          "{ fcitx5 -d -r; fcitx5-remote -r; }&"
          (optionals config.programs.waybar.enable "${pkgs.waybar}/bin/waybar&")
          (optionals config.services.hypridle.enable "${pkgs.hypridle}/bin/hypridle&")
          (optionals config.services.hyprpaper.enable "${pkgs.hyprpaper}/bin/hyprpaper&")
        ];

        "$terminal" = "alacritty";
        "$browser" = "librewolf";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun";

        env = [ "NIXOS_OZONE_WL,1" ];

        general = {
          gaps_in = homeConf.gaps-in;
          gaps_out = homeConf.gaps-out;

          border_size = 0;

          allow_tearing = false;
          layout = "dwindle";

          layerrule = [
            "blur,waybar"
            "blur,launcher"
            "blur,rofi"
            "ignorezero,rofi"
          ];
        };

        xwayland.force_zero_scaling = true;

        decoration = {
          rounding = homeConf.radius;

          active_opacity = 1.0;
          inactive_opacity = 0.8;

          blur = {
            enabled = false;
            size = 3;
            passes = 2;
            vibrancy = 0.1696;
          };

          shadow.enabled = false;
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInCubic,0.65,0,0.05.0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          middle_click_paste = false;
        };

        input = {
          kb_options = "caps:escape";
          repeat_delay = 400;
          repeat_rate = 40;

          follow_mouse = 1;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            tap-to-click = false;
            clickfinger_behavior = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_min_fingers = true;
          workspace_swipe_distance = 150;
        };

        workspace = [ "s[true],gapsout:40" ];

        windowrule = [
          "float,title:^(Picture-in-Picture)"
          "pin,title:^(Picture-in-Picture)"
        ];

        windowrulev2 = [
          "float, onworkspace:s[true]"
          "suppressevent maximize, class:.*" # You'll probably like this.
        ];

        monitor = map (
          m:
          let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in
          "${m.name},${if m.enabled then "${resolution},${position},${toString m.scale}" else "disable"}"
        ) (config.monitors);
      }
      // import ./binds.nix;
    };
  };
}
