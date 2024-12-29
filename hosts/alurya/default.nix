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

  nixpkgs.config.allowUnfree = true;
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

  hardware = {
    graphics = {
      enable = true;
      # driSupport = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
