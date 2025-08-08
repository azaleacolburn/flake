{
  keymaps = [
    # keep-sorted start block=yes
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize +2<CR>";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<CR>";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<CR>";
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize -2<CR>";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = ":Explor<CR>";
    }
    {
      mode = "n";
      key = "<leader>o";
      action = "<C-o>";
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<CR>";
    }

    {
      mode = "n";
      key = "l";
      action = "b";
    }
    {
      mode = "v";
      key = "l";
      action = "b";
    }
    {
      mode = "n";
      key = "b";
      action = "l";
    }
    {
      mode = "v";
      key = "b";
      action = "l";
    }

    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>Trouble diagnostics toggle<cr>";
    }
    # keep-sorted end
  ];
}
