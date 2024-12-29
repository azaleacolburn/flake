{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.homeConf = {
    username = mkOption {
      type = types.str;
      default = "azalea";
    };
    git = {
      userName = mkOption {
        type = types.str;
        default = "Azalea Colburn";
      };
      userEmail = mkOption {
        type = types.str;
        default = "azaleacolburn@gmail.com";
      };
    };
    radius = mkOption {
      type = types.int;
      default = 5;
      description = "border radius to use for stuff like the wm";
    };
    gaps-in = mkOption {
      type = types.int;
      default = 5;
    };
    gaps-out = mkOption {
      type = types.int;
      default = 10;
    };
    wallpaper = mkOption {
      type = types.path;
      default = ../../media/wallpapers/celeste.png;
    };
  };

  config = {
    assertions = [
      # {
      #   assertion = !(cfg.efi.enable && cfg.bios.enable);
      #   message = "cannot have bios and efi at the same time!!!";
      # }
    ];
  };
}
