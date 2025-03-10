{
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    mkMerge
    ;
  cfg = config.host.boot;
in
{
  options.host.boot = {
    enable = mkEnableOption "use default bios config";
    efi.enable = mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "use an efi bootloader";
    };
  };

  config.boot.loader = mkIf cfg.enable (mkMerge [
    { grub.enable = true; }
    (mkIf cfg.efi.enable {
      grub = {
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    })
  ]);
}
