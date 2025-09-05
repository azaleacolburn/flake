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
      terminal = 0.6;
      desktop = 0.8; # Doesn't affect waybar since stylix is disabled for it
      applications = 0.6;
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
        package = pkgs.iosevka-bin; # nerd-fonts.hack;
        name = "Iosevka";
      };

      emoji = config.stylix.fonts.monospace;

      sizes = {
        desktop = 12;
        terminal = 11.25;
      };
    };

    targets = {
      grub.enable = false;
      console.enable = false;
      nixvim.enable = false;
    };
  };
}
