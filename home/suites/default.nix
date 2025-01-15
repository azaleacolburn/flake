{lib, ...}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./base
    ./media
    ./desktop
    ./dev
    ./gaming
    ./academic
  ];

  suites.base.enable = mkDefault true;
}
