{
  plugins.telescope = {
    enable = true;
    extensions = {
      live-grep-args.enable = true;
      fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_generic_sorter = true;
          override_file_sorter = true;
          case_mode = "smart_case";
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Telescope buffers<cr>";
    }
    {
      mode = "n";
      key = "<leader>g";
      action = "<cmd>Telescope live_grep<cr>";
    }
    {
      mode = "n";
      key = "<leader>s";
      action = "<cmd>Telescope grep_string<cr>";
    }
  ];
  highlight = {
    TelescopeNormal = {
      bg = "#000000";
    };
  };
}
