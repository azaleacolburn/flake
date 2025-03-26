{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config) homeConf;
  cfg = config.services.dunst;
in
{
  services.dunst.settings = mkIf cfg.enable {
    global = {
      width = 350;
      origin = "bottom-right";
      offset = "16x16";
      progress_bar = true;
      progress_bar_corner_radius = homeConf.radius;
      corner_radius = homeConf.radius;
    };

    urgency_low.timeout = 5;
    urgency_normal.timeout = 5;
    urgency_critical.timeout = 1000;
  };
}
