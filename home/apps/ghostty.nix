{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.ghostty;
in
{
  config.programs.ghostty = {
    enableZshIntegration = true;
  };
  config.programs.ghostty.settings = lib.mkIf cfg.enable {
    mouse-hide-while-typing = true;
    command = lib.getExe pkgs.nushell;
  };
}
