{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.host.rgb;
in
{
  options.host.rgb.disable = lib.mkOption {
    type = lib.types.bool;
    description = "Disable all rgb that supports openrgb";
    default = true;
    example = false;
  };

  config = lib.mkIf cfg.disable {
    services.udev.packages = [ pkgs.openrgb ];
    boot.kernelModules = [ "i2c-dev" ];
    hardware.i2c.enable = true;

    systemd.services.no-rgb = {
      description = "no-rgb";
      serviceConfig = {
        ExecStart = "${pkgs.writeScriptBin "no-rgb" ''
          #!/bin/sh
          NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

          for i in $(seq 0 $(($NUM_DEVICES - 1))); do
            ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
          done
        ''}/bin/no-rgb";
        Type = "oneshot";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
