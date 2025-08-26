{ ... }:
{
  colorschemes.nord = {
    enable = true;
    settings = {
      # transparent_background = 2;
      disable_background = true;
      italic = false;
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
    relativenumber = false;
    fillchars = {
      eob = " ";
    };

    laststatus = 0;
    cursorline = false;
    swapfile = false;
  };
  highlightOverride = {
    Visual = {
      fg = "#FFFFFF";
      bg = "#88c0d0";
    };

  };

  autoCmd = [
    {
      event = [ "VimEnter" ];
      callback = {
        __raw = ''
            function(table)
              if vim.fn.argc() == 0 and vim.fn.expand("%:t") == "" then
              vim.schedule(function()
                require("telescope.builtin").find_files()
              end)
            end
          end'';
      };
    }
  ];
}
