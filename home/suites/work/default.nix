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
    xdg.mimeApps.defaultApplications = lib.flip lib.genAttrs (_: "zen-beta.desktop") [
      "application/pdf"
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/about"
      "x-scheme-handler/unknown"
    ];
    home.sessionVariables = {
      DEFAULT_BROWSER = lib.getExe config.programs.zen-browser.package;
      BROWSER = lib.getExe config.programs.zen-browser.package;
    };

    programs.zen-browser = {
      enable = true;
    };

    home = {
      packages = with pkgs; [
        chromium
      ];
    };

  };
}
