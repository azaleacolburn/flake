{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.programs.alacritty;
in
{
  config.programs.alacritty.settings = lib.mkIf cfg.enable {
    window.padding = {
      x = 8;
      y = 8;
    };
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
    terminal.shell.program = lib.getExe pkgs.nushell;
    terminal.shell.args = [ ];
    mouse.hide_when_typing = true;
  };
}
