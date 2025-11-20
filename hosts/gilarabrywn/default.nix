{
  pkgs,
  config,
  apple-silicon,
  inputs,
  ...
}:
let
  keyboard_layout = ''
    (deflayer base
        esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    d    r    w    b    j    f    u    p    ;    [    ]
        esc  a    s    h    t    g    y    n    e    o    i    '    ret
        lsft z    x    m    c    v    k    l    ,    .    /    rsft
        lctl lalt lmet           spc            rctl ralt rmet
    )
  '';
in
# keyboard_layout = ''
#   (deflayer base
#       esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
#       grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
#       tab  q    w    f    p    b    j    l    u    y    ;    [    ]
#       esc  a    r    s    t    g    m    n    e    i    o    '    ret
#       lsft z    x    c    d    v    k    h    ,    .    /    rsft
#       lctl lalt lmet           spc            rctl ralt rmet
#   )
# '';
{
  imports = [
    ./hardware.nix
    apple-silicon.nixosModules.apple-silicon-support
  ];

  # uefi
  host = {
    boot.enable = true;
    desktop.enable = true;
  };

  nixpkgs.overlays = [ apple-silicon.overlays.apple-silicon-overlay ];

  # Asahi Graphics and Firmware Support
  hardware.asahi = {
    enable = true;
    peripheralFirmwareDirectory = ./firmware;
    setupAsahiSound = true;
  };
  # Enable OpenGL Graphics
  hardware.graphics.enable = true;

  # setting AQ Graphics Card = needed for Hyprland
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/card0";
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "SDL_ttf-2.0.11"
    ];
    allowUnfree = true;
  };
  system.autoUpgrade.enable = true;

  # Sound Support and Config via Pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services = {
    libinput.enable = true;
    gvfs.enable = true;
    fwupd.enable = true;
  };

  programs.hyprland = {
    enable = true;
  };

  programs.dconf.enable = true;

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
            "/dev/input/by-path/platform-23510c000.spi-cs-0-event-kbd"
          ];

          config = ''
            (defsrc
                esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
                grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl lalt lmet           spc            rmet ralt rctl
            )

          ''
          + keyboard_layout;
        };
      };
  };

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
        slack.enable = false;
      };
      dev.enable = true;
      gaming.enable = false;
      media.enable = true;
      academic.enable = true;
    };

    monitors = [
      {
        name = "eDP-1";
        width = 2560;
        height = 1600;
        scale = 1.6;
      }
    ];
  };
}
