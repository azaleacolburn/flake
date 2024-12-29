{...}: {
  imports = [
    ./conform
    ./lsp
    ./telescope
    ./treesitter
    ./cmp
  ];

  plugins = {
    web-devicons.enable = true;
    comment.enable = true;
    nvim-autopairs.enable = true;
  };
}
