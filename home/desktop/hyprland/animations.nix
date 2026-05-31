{ lib, ... }:
{
  # TODO: https://github.com/nix-community/home-manager/pull/9307/changes#diff-248f530db4f3d25d8de2dd68a8457cccc9192e7b4aaf18594c8a361fb20e7692
  #       https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua
  #       https://codeberg.org/da157/nix-config/src/commit/cbbe3b747d3a3f51b93dd319db9049ad81a8d951/modules/home/desktops/hyprland/animations.nix
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;

    curve =
      lib.mapAttrsToList
        (name: value: {
          _args = [
            name
            value
          ];
        })
        {
          # "easeOutQuint,0.23,1,0.32,1"
          # "easeInCubic,0.55,0.055,0.675,0.19"
          # "linear,0,0,1,1"
          # "almostLinear,0.5,0.5,0.75,1"
          # "quick,0.15,0,0.1,1"
        };

    animation = [
      # "global, 1, 10, default"
      # "border, 1, 5.39, easeOutQuint"
      # "windows, 1, 4.79, easeOutQuint"
      # "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      # "windowsOut, 1, 1.49, linear, popin 87%"
      # "fadeIn, 1, 1.73, almostLinear"
      # "fadeOut, 1, 1.46, almostLinear"
      # "fade, 1, 3.03, quick"
      # "layers, 1, 3.81, easeOutQuint"
      # "layersIn, 1, 4, easeOutQuint, fade"
      # "layersOut, 1, 1.5, linear, fade"
      # "fadeLayersIn, 1, 1.79, almostLinear"
      # "fadeLayersOut, 1, 1.39, almostLinear"
      # "workspaces, 1, 1.94, almostLinear, fade"
      # "workspacesIn, 1, 1.21, almostLinear, fade"
      # "workspacesOut, 1, 1.94, almostLinear, fade"
    ];
  };
}
