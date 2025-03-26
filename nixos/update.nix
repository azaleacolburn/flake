{ lib, ... }:
{
  system.autoUpgrade = {
    flake = "git+https://github.com/azaleacolburn/flake.git";
    flags = [
      "-L"
      "--no-update-lock-file"
    ];
    dates = "03:30";
  };

  systemd.timers.nixos-upgrade.after = [ "network-online.target" ];
  systemd.timers.nixos-upgrade.wants = [ "network-online.target" ];
}
