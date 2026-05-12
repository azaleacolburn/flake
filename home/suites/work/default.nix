{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.work;
in
{
  options.suites.work.enable = mkEnableOption "Install work tools";

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  config = mkIf cfg.enable {

    programs.zen-browser.enable = true;

    home = {
      packages = with pkgs; [
        chromium
      ];
    };

  };
}
