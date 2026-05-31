{ lib, ... }:
{
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
          "easeInOutQuint" = {
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
          "easeInCubic" = {
            type = "bezier";
            points = [
              [
                0.55
                0.055
              ]
              [
                0.675
                0.19
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
        bezier = "easeInOutQuint";
      }
      {
        leaf = "windows";
        enabled = true;
        speed = 4.79;
        bezier = "easeInOutQuint";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4.1;
        bezier = "easeInOutQuint";
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
        bezier = "almostLinear";
        style = "fade";
      }
      {
        leaf = "workspacesIn";
        enabled = true;
        speed = 1.21;
        bezier = "almostLinear";
        style = "fade";
      }
      {
        leaf = "workspacesOut";
        enabled = true;
        speed = 1.94;
        bezier = "almostLinear";
        style = "fade";
      }
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 1.94;
        bezier = "almostLinear";
        # style = "slide";
        style = "fade";
      }
      # {
      #   leaf = "zoomFactor";
      #   enabled = true;
      #   speed = 7;
      #   bezier = "quick";
      # }
    ];
  };
}
