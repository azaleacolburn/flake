{ ... }:
{
  imports = [
    ./conform
    ./lsp
    ./telescope
    ./treesitter
    ./cmp
    ./trouble
  ];

  plugins = {
    web-devicons.enable = true;
    comment.enable = true;
    nvim-autopairs.enable = true;
  };
}
