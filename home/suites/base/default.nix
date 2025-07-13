# Tools needed even in a minimal install of nixos
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
      git.enable = true;
      ssh.enable = true;
      zsh.enable = true;
      jq.enable = true;
      ripgrep.enable = true;
      bat.enable = true;
    };

    home.packages = with pkgs; [
      tree
      stow
      vim
      du-dust
      fd
      procs
    ];
  };
}
