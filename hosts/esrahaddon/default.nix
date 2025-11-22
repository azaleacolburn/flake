# Copyright (c) 2024-2025 awwpotato <awwpotato@voidq.com>
{
  pkgs,
  inputs,
  config,
  ...
}:
let
  keyboard_layout = ''
    (deflayer base
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    f    p    b    j    l    u    y    ;    [    ]
        esc  a    r    s    t    g    m    n    e    i    o    '    ret
        lsft z    x    c    d    v    k    h    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rctl 
    )
  '';
in

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    ./hardware.nix
  ];

  host = {
    boot.enable = true;
    desktop = {
      enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  services = {
    fwupd.enable = true;
    # udev.packages = [ pkgs.android-udev-rules ];
  };

  services.kanata = {
    enable = true;
    keyboards =
      let
        extraDefCfg = ''
          process-unmapped-keys yes
        '';
      in
      {
        default = {
          inherit extraDefCfg;

          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];

          config = ''
            (defsrc
                esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
                grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl lalt lmet           spc            rmet ralt 
            )

          ''
          + keyboard_layout;
        };
      };
  };

  programs = {
    # nix-ld.enable = true;
    # nh.clean.enable = lib.mkForce false;
    hyprland.enable = true;
    dconf.enable = true;
  };

  # stylix.image = ../../../media/wallpapers/pink-flower-catpuccin.png;

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
        slack.enable = true;
        spotify.enable = true;
      };
      dev.enable = true;
      media.enable = true;
      academic.enable = true;
    };

    monitors = [
      {
        name = "eDP-1";
        width = 2256;
        height = 1504;
        scale = 1.566;
      }
    ];

  };
}
