{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.academic;
in
{
  options.suites.academic.enable = mkEnableOption "Install academic tools";

  inputs = {
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  config = mkIf cfg.enable {
    programs = {
    };

    home.packages = with pkgs; [
      chromium

    ];
  };
}
