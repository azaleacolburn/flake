{
  pkgs,
  config,
  ...
}:
{
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
      "SDL_ttf-2.0.11"
    ];
  };
  system.autoUpgrade.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.gvfs.enable = true;
  services.fwupd.enable = true;

  programs.dconf.enable = true;
  programs.hyprland.enable = true;

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
        slack.enable = true;
        spotify.enable = true;
      };
      academic.enable = false;
      dev.enable = true;
      gaming.enable = true;
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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    xone.enable = true;
  };
}
