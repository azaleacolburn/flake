{ ... }:
{
  imports = [
    ./git
    ./ssh
    ./starship
    ./zsh
  ];

  home.shellAliases = {
    tree = "tree -C -a -I .git -I __pycache__ -I target";
    ls = "eza -A --color=auto -s type";
    ll = "eza -Al --color=auto -s type";
    lt = "eza -AT --color=auto -I .git -s type";

    uwu = "fastfetch";
    e = "nvim";
    update = "nh os switch";

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
}
