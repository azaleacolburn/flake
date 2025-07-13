{
  lib,
  config,
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
    command = "/etc/profiles/per-user/azalea/bin/nu";
  };
}
