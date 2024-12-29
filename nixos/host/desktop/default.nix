{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkMerge mkDefault mkPackageOption;
  cfg = config.host.desktop;
in {
  options.host.desktop = {
    enable = mkEnableOption "Enable desktop configs";
    unbindPowerButton = mkEnableOption "Unbind power button";
    bluetooth.enable = mkEnableOption "Enable bluetooth + tools";
    audio.enable = mkEnableOption "Enable audio + tools";
    printing.enable = mkEnableOption "Enable printing";
    mullvad = {
      enable = mkEnableOption "Enable mullvad vpn";
      package = mkPackageOption pkgs "mullvad-vpn" {
        example = "mullvad";
        extraDescription = ''
          `pkgs.mullvad` only provides the CLI tool, `pkgs.mullvad-vpn` provides both the CLI and the GUI.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      host.desktop = {
        unbindPowerButton = mkDefault true;
        bluetooth.enable = mkDefault true;
        audio.enable = mkDefault true;
        printing.enable = mkDefault true;
        mullvad.enable = mkDefault true;
      };
    })
    (mkIf cfg.unbindPowerButton {
      services.logind.extraConfig = "HandlePowerKey=ignore";
    })
    (mkIf cfg.bluetooth.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      environment.systemPackages = [pkgs.bluetui];
    })
    (mkIf cfg.audio.enable {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
      environment.systemPackages = with pkgs; [
        pavucontrol
      ];
    })
    {services.printing.enable = cfg.printing.enable;}
    {
      services.mullvad-vpn = {
        enable = cfg.mullvad.enable;
        package = cfg.mullvad.package;
      };
    }
  ];
}
