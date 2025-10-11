# Copyright (c) 2024-2025 awwpotato <awwpotato@voidq.com>
{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13th-gen-amd
    (self.diskoModules.luks-btrfs { disk = "/dev/nvme0n1"; })
    ./hardware.nix
  ];

  host = {
    boot.enable = true;
    desktop = {
      enable = true;
      tuned.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "potato" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    distrobox
    fw-ectool
  ];

  services = {
    fwupd.enable = true;
    # udev.packages = [ pkgs.android-udev-rules ];
  };

  networking.firewall.allowedTCPPorts = [
    9090 # calibre
  ];

  programs = {
    nix-ld.enable = true;
    nh.clean.enable = lib.mkForce false;
    hyprland.enable = true;
    steam.enable = true;
  };

  # stylix.image = ../../../media/wallpapers/pink-flower-catpuccin.png;

  monitors = lib.singleton {
    name = "eDP-1";
    width = 2256;
    height = 1504;
    scale = 1.566;
  };

  home-manager.users.azalea = {
    suites = {
      desktop = {
        enable = true;
        hyprland.enable = true;
      };
      dev.enable = true;
      media.enable = true;
    };

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-chinese-addons
        ];
        settings = import ./fcitx5-settings.nix;
      };
    };

    programs.zen-browser = {
      enable = true;
      profiles = {
        school = {
          id = 0;
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
            darkreader
            return-youtube-dislikes
            sponsorblock
            duckduckgo-privacy-essentials
            facebook-container
          ];
          settings = {
            "zen.view.experimental-no-window-controls" = true;
          };
        };
      };
    };
  };
}
