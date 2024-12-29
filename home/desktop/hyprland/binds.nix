{
  bind =
    [
      # programs
      "SUPER, T, exec, $terminal"
      "SUPER, RETURN, exec, $menu"
      "SUPER, E, exec, $fileManager"
      "SUPER, escape, exec, hyprlock"

      "SUPER shift, K, exit"
      "SUPER, Q, killactive"
      "SUPER, P, pin,"
      "SUPER, F, togglefloating"
      "SUPER, I, pseudo," # dwindle
      "SUPER, U, togglesplit," # dwindle

      "SUPER, Tab, cyclenext"
      "SUPER SHIFT, Tab, cyclenext, prev"

      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"

      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      ", PRINT, exec, grimblast save output - | swappy -f -"
      "SHIFT, PRINT, exec, grimblast save area - | swappy -f -"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
          x: [
            "SUPER, ${toString (x + 1)}, workspace, ${toString (x + 1)}"
            "SUPER SHIFT, ${toString (x + 1)}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        9)
    );

  binde = [
    "SUPER, left, movefocus, l"
    "SUPER, right, movefocus, r"
    "SUPER, up, movefocus, u"
    "SUPER, down, movefocus, d"

    "SUPER&SHIFT, H, resizeactive, -10 0"
    "SUPER&SHIFT, L, resizeactive, 10 0"
    "SUPER&SHIFT, K, resizeactive, 0 -10"
    "SUPER&SHIFT, J, resizeactive, 0 10"

    ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    "Shift, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
    "Shift, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"

    ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
    "Shift, XF86MonBrightnessUp, exec, brightnessctl s 1%+"
    ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    "Shift, XF86MonBrightnessDown, exec, brightnessctl s 1%-"
  ];

  bindm = [
    "SUPER, mouse:272, movewindow"
    "SUPER, mouse:273, resizewindow"
  ];
}
