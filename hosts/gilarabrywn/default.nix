{
  pkgs,
  config,
  apple-silicon,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    apple-silicon.nixosModules.apple-silicon-support
  ];

  # uefi
  host = {
    boot.enable = true;
    desktop.enable = true;
  };

  nikpkgs.overlays = [apple-silicon.overlays.apple-silicon-overlay];

  # Asahi Graphics and Firmware Support
  hardware.asahi = {
    enable = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    peripheralFirmwareDirectory = ./firmware;
    withRust = true;
    setupAsahiSound = true;
  };
  # settings WLR Graphics Card - needed for Hyprland
  hardware.graphics.enable = true;

  # setting AQ Graphics Card = needed for Hyprland
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/card0";
  };

  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;

  # Sound Support and Config via Pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # ly not needed but dm is ? weird
  # not having ly on desktop borks hyprland, so it's set based on host
  services.displayManager = {
    enable = true;
    ly.enable = false;
  };

  services = {
    libinput.enable = true;
    gvfs.enable = true;
    fwupd.enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.dconf.enable = true;

  services.kanata = {
    enable = true;
    keyboards = let
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    in {
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

          (deflayer base
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    d    r    w    b    j    f    u    p    ;    [    ]
              esc  a    s    h    t    g    y    n    e    o    i    '    ret
              lsft z    x    m    c    v    k    l    ,    .    /    rsft
              lctl lalt lmet           spc            rctl ralt rmet
          )
        '';
      };
    };
  };

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
      };
      dev.enable = true;
      gaming.enable = false;
      media.enable = false;
    };

    monitors = [
      {
        name = "";
        width = 1920;
        height = 1080;
        scale = 1.5;
      }
    ];
  };
}
