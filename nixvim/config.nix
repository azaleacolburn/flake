{...}: {
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      transparent_background = true;
      style = "storm";
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
    fillchars = {eob = " ";};

    laststatus = 0;
    cursorline = false;
    swapfile = false;
  };
}
