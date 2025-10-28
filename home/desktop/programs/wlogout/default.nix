{
  lib,
  config,
  ...
}:
let
  inherit (config.lib.stylix.colors.withHashtag)
    base00
    base01
    base02
    base03
    base04
    base05
    base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;
  cfg = config.programs.wlogout;
  fonts = config.stylix.fonts;
in
{
  config.programs.wlogout = lib.mkIf cfg.enable {
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Exit";
        keybind = "e";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];
    style = ''
      @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};

      @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

      * {
        font-family: ${fonts.monospace.name};
        font-size: 25px;
      }

      #lock {
        background-image: image(url("${./icons/lock.png}"));
      }

      #shutdown {
        background-image: image(url("${./icons/shutdown.png}"));
      }

      #reboot {
        background-image: image(url("${./icons/reboot.png}"));
      }

      #suspend {
        background-image: image(url("${./icons/suspend.png}"));
      }

      #logout {
        background-image: image(url("${./icons/logout.png}"));
      }

      #hibernate {
        background-image: image(url("${./icons/hibernate.png}"));
      }
    ''
    + (builtins.readFile ./style.css);
  };
}
