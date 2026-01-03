{ ... }:
{
  imports = [
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./zsh.nix
    ./nushell.nix
    ./fish.nix
  ];

  home.shellAliases = {
    tree = "tree -C -a -I .git -I __pycache__ -I target";
    ll = "eza -Al --color=auto -s type";
    lt = "eza -AT --color=auto -I .git -s type";

    uwu = "fastfetch";
    e = "nvim";
    update = "nh os switch ~/flake";
    keygen = "ssh-keygen -t ed25519 -a 4000 -f ~/.ssh/github_ed25519";

    st = "z";
    zc = "z; clear";
    rf = "rm -rf";
    ip = "ip -c";

    # Git
    c = "git commit -a";
    push = "git push";
    pull = "git pull";
    checkout = "git checkout";
  };
}
