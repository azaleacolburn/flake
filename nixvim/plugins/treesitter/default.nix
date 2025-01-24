{
  plugins.treesitter = {
    enable = true;
    settings = {
      ensureInstalled = [
        # Systems
        "c"
        "rust"
        "rust"
        # Shell
        "bash"
        # "zsh"
        # Webdev
        "html"
        "css"
        "javascript"
        "typescript"
        "svelte"
        # Config
        "nix"
        "lua"
        "luadoc"
        "vim"
        "vimdom"
        "yaml"
        "toml"
        "editorconfig"
        # Misc
        "diff"
        "query"
        "markdown"
        "markdown_inline"
        "latex"
      ];
      highlight = {
        enable = true;
        # additional_vim_regex_highlighting = true;
      };
      indent.enable = true;
    };
  };
}
