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
    font = {
      normal = {
        family = "Hack Nerd Font";
        style = "Regular";
      };
      italic = {
        family = "Hack Nerd Font";
        style = "Italic";
      };
      bold = {
        family = "Hack Nerd Font";
        style = "Bold";
      };
    };
  };
}
