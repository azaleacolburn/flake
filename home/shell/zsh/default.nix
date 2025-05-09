{
  lib,
  config,
  ...
}:
{
  config.programs = lib.mkIf config.programs.zsh.enable {
    starship.enable = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    zsh = {
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";

      history.path = "${config.xdg.dataHome}/zsh/zsh_history";
      dotDir = ".config/zsh";
      completionInit = "mkdir -p ~/.cache/zsh; autoload -Uz compinit; compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION";
    };

    # For `nix develop`
    # bash = {
    #   enable = true;
    #   shellAliases = aliases;
    # };
  };
}
