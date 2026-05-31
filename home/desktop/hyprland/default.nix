{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption optionals;
  inherit (config) homeConf;
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland.enable = mkEnableOption "Enable hyprland desktop";

  imports = [ ./binds.nix ];

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

      configType = "lua";
      settings = {
        on._args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              ${lib.optionalString config.programs.waybar.enable ''hl.exec_cmd("${lib.getExe pkgs.waybar}")''}
              ${lib.optionalString config.services.hypridle.enable ''hl.exec_cmd("${lib.getExe pkgs.hypridle}")''}
              ${lib.optionalString config.services.hyprpaper.enable ''hl.exec_cmd("${lib.getExe pkgs.hyprpaper}")''}
            end
          '')
        ];

        env = [
          {
            _args = [
              "NIXOS_OZONE_WL"
              "1"
            ];
          }
        ];

        config = {
          debug.disable_logs = false;

          general = {
            gaps_in = homeConf.gaps-in;
            gaps_out = homeConf.gaps-out;

            border_size = 0;

            allow_tearing = false;
            layout = "dwindle";
          };

          xwayland.force_zero_scaling = true;

          decoration = {
            rounding = homeConf.radius;

            active_opacity = 1.0;
            inactive_opacity = 0.8;

            blur = {
              enabled = true;
              size = 3;
              passes = 2;
              vibrancy = 0.1696;
            };

            shadow.enabled = false;
          };

          dwindle = {
            # pseudotile = true;
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
              tap_to_click = true;
              clickfinger_behavior = true;
            };
          };
        };

        workspace_rule = [
          {
            workspace = "s[true]";
            gaps_out = 40;
          }
        ];

        window_rule = [
          {
            match.class = ".*";
            suppress_event = "maximize";
          }
          {
            match.title = "Picture-in-Picture";
            float = true;
            pin = true;
          }
          {
            match.workspace = "s[true]";
            float = true;
          }
        ];

        layer_rule = [
          {
            match.class = "(waybar|launcher|rofi|notifications)";
            blur = true;
            ignore_alpha = 0;
          }
        ];

        monitor =
          map (
            m:
            if m.enabled then
              {
                output = m.name;
                mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                position = "${toString m.x}x${toString m.y}";
                scale = toString m.scale;
              }
            else
              {
                output = m.name;
                disabled = true;
              }
          ) (config.monitors)
          ++ [
            {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = "auto";
            }
          ];
      };
    };
  };
}
