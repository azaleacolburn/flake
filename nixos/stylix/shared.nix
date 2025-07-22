{
  lib,
  pkgs,
  config,
  ...
}:
{
  stylix = {
    enable = lib.mkDefault true;

    polarity = "dark";
    image = config.homeConf.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    opacity = {
      terminal = 1.0;
      desktop = 1.0;
      applications = 1.0;

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
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
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
