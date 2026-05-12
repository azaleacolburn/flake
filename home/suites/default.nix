{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./base
    ./media
    ./desktop
    ./dev
    ./gaming
    ./academic
    ./work
  ];

  suites.base.enable = mkDefault true;
}
