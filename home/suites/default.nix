{lib, ...}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./base
    ./media
    ./desktop
    ./dev
    ./gaming
  ];

  suites.base.enable = mkDefault true;
}
