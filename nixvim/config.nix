{ ... }:
{
  colorschemes.nord = {
    enable = true;
    settings = {
      transparent_background = true;
    };
  };
  clipboard = {
    providers.wl-copy.enable = true;
    register = "unnamedplus";
  };
  globals = {
    mapleader = " ";
    maplocalleader = " ";

    netrw_liststyle = 1;
  };
  opts = {
    expandtab = true;
    smartindent = true;
    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 4;

    wrap = false;
    number = true;
    relativenumber = true;
    fillchars = {
      eob = " ";
    };

    laststatus = 0;
    cursorline = false;
    swapfile = false;
  };
  # autoCmd = [
  #   {
  #     event = [ "VimEnter" ];
  #     callback = {
  #       __raw = ''
  #         function()
  #           local bufname = vim.fn.expand("%:t")
  #           if vim.bo.filetype ~= "gitcommit" and bufname == "" then
  #             require("telescope.builtin").find_files()
  #           end
  #         end'';
  #     };
  #   }
  # ];
}
