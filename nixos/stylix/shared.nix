{
  lib,
  pkgs,
  config,
  ...
}: let
  mapleMono7 = pkgs.maple-mono-NF.overrideAttrs {
    version = "7.0-beta31";
    src = pkgs.fetchurl {
      url = "https://github.com/subframe7536/maple-font/releases/download/v7.0-beta31/MapleMono-NF-CN-unhinted.zip";
      sha256 = "sha256-38KOKUMITmHe9/GqC6tiGy25Y8fI04sifhyQjbZQW0g=";
    };
  };
in {
  stylix = {
    enable = lib.mkDefault true;

    polarity = "dark";
    image = config.homeConf.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    opacity = {
      terminal = 1.0;
      desktop = 1.0;
      popups = 0.6;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = mapleMono7;
        name = "Maple Mono NF CN";

        # package = pkgs.nerdfonts.override {
        #   fonts = ["FiraMono"];
        # };
        # name = "FiraMono Nerd Font Propo";
      };

      emoji = config.stylix.fonts.monospace;

      sizes = {
        desktop = 12;
        terminal = 10;
      };
    };

    targets = {
      grub.enable = false;
      console.enable = false;
      nixvim.enable = false;
    };
  };
}
