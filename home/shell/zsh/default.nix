{
  lib,
  config,
  ...
}:
let
  aliases = {
    tree = "tree -C -a -I .git -I __pycache__ -I target";
    ls = "eza -A --color=auto -s type";
    ll = "eza -Al --color=auto -s type";
    lt = "eza -AT --color=auto -I .git -s type";

    uwu = "fastfetch";
    e = "nvim";
    update = "sudo nixos-rebuild switch --flake ~/flake";
    keygen = "ssh-keygen -t ed25519 -a 4000 -f ~/.ssh/codeberg_ed25519 && ssh-keygen -t ed25519 -a 4000 -f ~/.ssh/github_ed25519";

    th = "z";
    zc = "z; clear";
    rf = "rm -rf";
    ip = "ip -c";

    # Git
    c = "git commit -a";
    push = "git push";
    pull = "git pull";
    switch = "git switch";
    checkout = "git checkout";
  };
  cfg = config.programs.zsh;
in
{
  config.programs = lib.mkIf cfg.enable {
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

      shellAliases = aliases;

      history.path = "${config.xdg.dataHome}/zsh/zsh_history";
      dotDir = ".config/zsh";
      completionInit = "mkdir -p ~/.cache/zsh; autoload -Uz compinit; compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION";
    };

    # For `nix develop`
    bash = {
      enable = true;
      shellAliases = aliases;
    };
  };
}
