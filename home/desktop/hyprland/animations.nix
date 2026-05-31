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
          "easeOutQuint" = {
            type = "bezier";
            points = [
              [
                0.23
                1
              ]
              [
                0.32
                1
              ]
            ];
          };
          "easyInOutCubic" = {
            type = "bezier";
            points = [
              [
                0.65
                0.05
              ]
              [
                0.36
                1
              ]
            ];
          };
          "linear" = {
            type = "bezier";
            points = [
              [
                0
                0
              ]
              [
                1
                1
              ]
            ];
          };
          "almostLinear" = {
            type = "bezier";
            points = [
              [
                0.5
                0.5
              ]
              [
                0.75
                1
              ]
            ];
          };
          "quick" = {
            type = "bezier";
            points = [
              [
                0.15
                0
              ]
              [
                0.1
                1
              ]
            ];
          };
          "easy" = {
            type = "spring";
            mass = 1;
            stiffness = 71.2633;
            dampening = 15.8273644;
          };

        };

    animation = [
      {
        leaf = "global";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 5.39;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windows";
        enabled = true;
        speed = 4.79;
        spring = "easy";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4.1;
        spring = "easy";
        style = "popin 87%";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 1.49;
        bezier = "linear";
        style = "popin 87%";
      }
      {
        leaf = "fadeIn";
        enabled = true;
        speed = 1.73;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeOut";
        enabled = true;
        speed = 1.46;
        bezier = "almostLinear";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 3.03;
        bezier = "quick";
      }
      {
        leaf = "layers";
        enabled = true;
        speed = 3.81;
        bezier = "easeOutQuint";
      }
      {
        leaf = "layersIn";
        enabled = true;
        speed = 4;
        bezier = "easeOutQuint";
        style = "fade";
      }
      {
        leaf = "layersOut";
        enabled = true;
        speed = 1.5;
        bezier = "linear";
        style = "fade";
      }
      {
        leaf = "fadeLayersIn";
        enabled = true;
        speed = 1.79;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeLayersOut";
        enabled = true;
        speed = 1.39;
        bezier = "almostLinear";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 1.94;
        bezier = "easyInOutCubic";
        style = "slidevert";
      }
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 4;
        bezier = "easyInOutCubic";
        style = "slide";
      }
      {
        leaf = "zoomFactor";
        enabled = true;
        speed = 7;
        bezier = "quick";
      }
    ];
  };
}
