{
  lib,
  config,
  ...
}: let
  cfg = config.programs.alacritty;
in {
  config.programs.alacritty.settings = lib.mkIf cfg.enable {
    window.padding = {
      x = 4;
      y = 4;
    };
    keyboard.bindings = [
      {
        key = "Q";
        mods = "Control|Shift";
        action = "quit";
      }
    ];
  };
}