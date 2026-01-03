{ config, ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    starship.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      icons = "auto";
      enableFishIntegration = true;
    };

    # For `nix develop`
    bash = {
      enable = true;
      enableCompletion = true;
      historyFile = "${config.xdg.dataHome}/bash/bash_history";
    };

  };
}
