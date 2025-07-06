{
  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true 
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100 
             completer: $carapace_completer # check 'carapace_completer' 
           }
         }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        tree = "tree -C -a -I .git -I __pycache__ -I target";
        ls = "eza -A --color=auto -s type";
        ll = "eza -Al --color=auto -s type";
        lt = "eza -AT --color=auto -I .git -s type";

        uwu = "fastfetch";
        e = "nvim";
        update = "sudo nh os switch --flake ~/flake";
        # keygen = "ssh-keygen -t ed25519 -a 4000 -f ~/.ssh/codeberg_ed25519; ssh-keygen -t ed25519 -a 4000 -f ~/.ssh/github_ed25519";

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
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    starship.enable = true;
  };
}
