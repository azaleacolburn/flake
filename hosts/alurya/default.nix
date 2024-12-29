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
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };

  home-manager.users.${config.homeConf.username} = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
      };
      dev.enable = true;
      gaming.enable = false;
      media.enable = true;
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
