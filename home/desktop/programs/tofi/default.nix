{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkForce;
  inherit (config) homeConf;
  cfg = config.programs.tofi;
in {
  programs.tofi.settings = mkIf cfg.enable {
    prompt-text = "> ";

    font-size = mkForce 20;
    num-results = 20;
    width = "40%";
    height = "60%";

    corner-radius = homeConf.radius;
    border-width = 0;
    outline-width = 0;
  };
}
