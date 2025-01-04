{
  pkgs,
  config,
  apple-silicon,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
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

  hardware.graphics.enable = true;

  # setting AQ Graphics Card = needed for Hyprland
  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/card0";
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services = {
    libinput.enable = true;
    gvfs.enable = true;
    fwupd.enable = true;
  };

  services.displayManager = {
    enable = true;
    ly.enable = false;
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
                 q w e r t y u i o p
            caps a s d f g h j k l ; '
                 z x c v b n m , . /
                   spc
           )
            		
           (deflayer base
          q d r w b j f u p ;
            esc  a s h t g y n e o i '
          z x m c v k l , . /
             spc
           )'';
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
