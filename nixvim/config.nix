{ ... }:
{
  colorschemes.everforest = {
    enable = true;
    settings = {
      transparent_background = 1;
      background = "soft";
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
  #             -- vim.cmd("<cmd>Telescope find_files<cr>")
  #             require("telescope.builtin").find_files()
  #           end
  #         end'';
  #     };
  #   }
  # ];
}
