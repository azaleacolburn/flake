{...}: {
  imports = [
    ./conform
    ./lsp
    ./telescope
    ./treesitter
    ./cmp
    ./trouble
    ./markview
    ./vimtex
  ];

  plugins = {
    web-devicons.enable = true;
    comment.enable = true;
    nvim-autopairs.enable = true;
  };
}
