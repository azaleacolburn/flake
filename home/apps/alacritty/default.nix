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
        family = "Iosevka";
        style = "Regular";
      };
      italic = {
        family = "Iosevka";
        style = "Italic";
      };
      bold = {
        family = "Iosevka";
        style = "Bold";
      };
    };
    terminal.shell.program = lib.getExe pkgs.nushell;
    terminal.shell.args = [ ];
    mouse.hide_when_typing = true;
  };
}
