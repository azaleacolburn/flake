{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkMerge
    mkDefault
    ;
  cfg = config.host.desktop;
in
{
  options.host.desktop = {
    enable = mkEnableOption "Enable desktop configs";
    unbindPowerButton = mkEnableOption "Unbind power button";
    bluetooth.enable = mkEnableOption "Enable bluetooth + tools";
    audio.enable = mkEnableOption "Enable audio + tools";
    printing.enable = mkEnableOption "Enable printing";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      host.desktop = {
        unbindPowerButton = mkDefault true;
        bluetooth.enable = mkDefault true;
        audio.enable = mkDefault false;
        printing.enable = mkDefault true;
      };

      programs.regreet.enable = true;
      # services.greetd.settings.default_session = {
      #   command = "hyprland --config /etc/greetd/";
      #   user = "azalea";
      # };
      services.displayManager = {
        enable = lib.mkForce false;
        execCmd = "${pkgs.greetd.regreet}/bin/regreet";
      };
      services.tcsd.enable = false;
    })
    (mkIf cfg.unbindPowerButton {
      services.logind.settings.Login.HandlePowerKey = "ignore";
    })
    (mkIf cfg.bluetooth.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      environment.systemPackages = [ pkgs.bluetui ];
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
    { services.printing.enable = cfg.printing.enable; }
  ];
}
