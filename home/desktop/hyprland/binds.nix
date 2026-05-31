{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;

  exec = text: mkLuaInline ''hl.dsp.exec_cmd("${text}")'';
in
let

  # Window Manipulation
  window_binds =
    (lib.concatMapAttrs (
      key:
      {
        direction,
        x ? "0",
        y ? "0",
      }:
      {
        # Resizing
        "SUPER + SHIFT + ${key}" = [
          (mkLuaInline "hl.dsp.window.resize({ relative = true, x = ${x}, y = ${y} })")
          { repeating = true; }
        ];

        # Set Focus
        "SUPER + ${direction}" = (mkLuaInline ''hl.dsp.focus({ direction = "${direction}" })'');

        # Move Window Within Workspace
        "SUPER + SHIFT + ${direction}" = [
          (mkLuaInline ''hl.dsp.window.move({ direction = "${direction}" })'')
          { repeating = true; }
        ];
      }
    ))

      {
        H = {
          direction = "left";
          x = "-10";
        };
        L = {
          direction = "right";
          x = "10";
        };
        K = {
          direction = "up";
          y = "-10";
        };
        J = {
          direction = "down";
          y = "10";
        };
      };

in
{
  wayland.windowManager.hyprland.settings.bind =
    lib.mapAttrsToList
      (name: value: {
        _args =
          if lib.isList value then
            [ name ] ++ value
          else
            [
              name
              value
            ];
      })
      (
        {
          # programs
          "SUPER + T" = exec "alacritty";
          "SUPER + N" = exec "zen-beta";
          "SUPER + RETURN" = exec "rofi -show drun";
          "SUPER + E" = exec "dolphin";
          "SUPER + L" = exec "hyprlock";

          "SUPER + SHIFT + M" = mkLuaInline "hl.dsp.exit()";
          "SUPER + Q" = mkLuaInline "hl.dsp.window.kill()";
          "SUPER + O" = mkLuaInline "hl.dsp.window.pin()";
          "SUPER + F" = mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'';
          # "SUPER, I, pseudo," # dwindle
          # "SUPER, U, togglesplit," # dwindle
          "SUPER + W" = exec "pkill waybar || waybar";

          "SUPER + Tab" = mkLuaInline ''hl.dsp.focus({ workspace = "e+1" })'';
          "SUPER + SHIFT + Tab" = mkLuaInline ''hl.dsp.focus({ workspace = "e-1" })'';

          "SUPER + S" = mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'';
          "SUPER + SHIFT + S" = mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'';

          "XF86AudioMute" = exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "SUPER + P" = exec "grimblast save output - | swappy -f -";
          "SUPER + SHIFT + P" = exec "grimblast save area - | swappy -f -";
        }
        // window_binds
        // {

          "XF86AudioRaiseVolume" = [
            (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
            { repeating = true; }
          ];
          "XF86AudioLowerVolume" = [
            (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
            { repeating = true; }
          ];
          "SHIFT + XF86AudioRaiseVolume" = [
            (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+")
            { repeating = true; }
          ];
          "SHIFT + XF86AudioLowerVolume" = [
            (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
            { repeating = true; }
          ];

          "XF86MonBrightnessUp" = [
            (exec "brightnessctl s 5%+")
            { repeating = true; }
          ];
          "SHIFT + XF86MonBrightnessUp" = [
            (exec "brightnessctl s 1%+")
            { repeating = true; }
          ];
          "XF86MonBrightnessDown" = [
            (exec "brightnessctl s 5%-")
            { repeating = true; }
          ];
          "SHIFT + XF86MonBrightnessDown" = [
            (exec "brightnessctl s 1%-")
            { repeating = true; }
          ];

          "SUPER + mouse:272" = [
            (mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
          "SUPER + mouse:273" = [
            (mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
        // lib.mergeAttrsList (
          lib.genList (x: {
            "SUPER + ${toString (x + 1)}" = mkLuaInline "hl.dsp.focus({ workspace = ${toString (x + 1)}})";
            "SUPER + SHIFT + ${toString (x + 1)}" =
              mkLuaInline "hl.dsp.window.move({ workspace = ${toString (x + 1)}})";
          }) 9
        )
      );
}
