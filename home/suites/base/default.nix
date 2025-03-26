{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.suites.base;
in
{
  options.suites.base.enable = mkEnableOption "Install base tools";

  config = mkIf cfg.enable {
    programs = {
      btop.enable = true;
      git.enable = true;
      ssh.enable = true;
      zsh.enable = true;
      ripgrep.enable = true;
    };

    home.packages = with pkgs; [
      tree
      stow
      jq
    ];
  };
}
