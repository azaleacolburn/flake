{
  plugins.treesitter = {
    enable = true;
    settings = {
      ensureInstalled = [
        "bash"
        "c"
        "diff"
        "html"
        "lua"
        "luadoc"
        "markdown"
        "markdown_inline"
        "query"
        "vim"
        "vimdoc"
        "nix"
        "rust"
        "yaml"
        "html"
        "css"
        "javascript"
        "typescript"
        "editorconfig"
      ];
      highlight = {
        enable = true;
        # additional_vim_regex_highlighting = true;
      };
      indent.enable = true;
    };
  };
}
