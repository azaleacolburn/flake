{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  # uefi
  host = {
    boot.enable = true;
    desktop.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-19.1.9"
    ];
  };
  system.autoUpgrade.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.displayManager = {
    enable = true;
    execCmd = "${pkgs.greetd.regreet}/bin/regreet";
  };

  services.libinput.enable = true;
  services.gvfs.enable = true;
  services.fwupd.enable = true;

  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.regreet.enable = true;

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
        slack.enable = true;
        spotify.enable = true;
      };
      dev.enable = true;
      gaming.enable = false;
      media.enable = true;
    };

    monitors = [
      {
        name = "HDMI-A-1";
        width = 1920;
        height = 1080;
        scale = 1.0;
      }
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
