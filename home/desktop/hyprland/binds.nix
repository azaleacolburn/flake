{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;

  exec = text: mkLuaInline ''hl.dsp.exec_cmd("${text}")'';
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
          # movement TODO: unsure which move https://wiki.hypr.land/Configuring/Basics/Dispatchers/#window-1
          "SUPER + SHIFT + left" = [
            (mkLuaInline ''hl.dsp.window.move({ into_group = "left" })'')
            { repeating = true; }
          ];
          "SUPER + SHIFT + right" = [
            (mkLuaInline ''hl.dsp.window.move({ into_group = "right" })'')
            { repeating = true; }
          ];
          "SUPER + SHIFT + up" = [
            (mkLuaInline ''hl.dsp.window.move({ into_group = "up" })'')
            { repeating = true; }
          ];
          "SUPER + SHIFT + down" = [
            (mkLuaInline ''hl.dsp.window.move({ into_group = "down" })'')
            { repeating = true; }
          ];
          # programs
          "SUPER + T" = exec "alacritty";
          "SUPER + N" = exec "liberwolf";
          "SUPER + RETURN" = exec "rofi -show drun";
          "SUPER + E" = exec "dolphin";
          "SUPER + L" = exec "hyprlock";

          # FIXME: conflict
          # "SUPER + SHIFT + K" = mkLuaInline "hl.dsp.exit()";
          "SUPER + Q" = mkLuaInline "hl.dsp.window.kill()";
          "SUPER + O" = mkLuaInline "hl.dsp.window.pin()";
          "SUPER + F" = mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'';
          # "SUPER, I, pseudo," # dwindle
          # "SUPER, U, togglesplit," # dwindle
          "SUPER + W" = exec "pkill waybar || waybar";

          # "SUPER, Tab, workspace, m+1"
          # "SUPER SHIFT, Tab, workspace, m-1"

          "SUPER + S" = mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'';
          "SUPER + SHIFT + S" = mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'';

          "XF86AudioMute" = exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" = exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          "SUPER + P" = exec "grimblast save output - | swappy -f -";
          "SUPER + SHIFT + P" = exec "grimblast save area - | swappy -f -";

          "SUPER + SHIFT + H" = [
            (mkLuaInline "hl.dsp.window.resize({ relative = true, x = -10, y = 0 })")
            { repeating = true; }
          ];
          "SUPER + SHIFT + L" = [
            (mkLuaInline "hl.dsp.window.resize({ relative = true, x = 10, y = 0 })")
            { repeating = true; }
          ];
          "SUPER + SHIFT + K" = [
            (mkLuaInline "hl.dsp.window.resize({ relative = true, x = 0, y = -10 })")
            { repeating = true; }
          ];
          "SUPER + SHIFT + J" = [
            (mkLuaInline "hl.dsp.window.resize({ relative = true, x = 0, y = 10 })")
            { repeating = true; }
          ];

          "XF86AudioRaiseVolume" = [
            (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
            { repeating = true; }
          ];
          "XF86AudioLowerVolume" = [
            (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
            { repeating = true; }
          ];
          "Shift + XF86AudioRaiseVolume" = [
            (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+")
            { repeating = true; }
          ];
          "Shift + XF86AudioLowerVolume" = [
            (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-")
            { repeating = true; }
          ];

          "XF86MonBrightnessUp" = [
            (exec "brightnessctl s 5%+")
            { repeating = true; }
          ];
          "Shift + XF86MonBrightnessUp" = [
            (exec "brightnessctl s 1%+")
            { repeating = true; }
          ];
          "XF86MonBrightnessDown" = [
            (exec "brightnessctl s 5%-")
            { repeating = true; }
          ];
          "Shift + XF86MonBrightnessDown" = [
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
