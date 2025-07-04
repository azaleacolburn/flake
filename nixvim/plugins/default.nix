{ ... }:
{
  imports = [
    ./conform
    ./lsp
    ./telescope
    ./treesitter
    ./cmp
    ./trouble
    # ./noice
  ];

  plugins = {
    web-devicons.enable = true;
    comment.enable = true;
    nvim-autopairs.enable = true;
    noice.enable = true;
  };
}
