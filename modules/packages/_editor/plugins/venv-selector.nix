{
  plugins.venv-selector = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>vs";
      action = "<cmd>VenvSelect<cr>";
      options.desc = "Select Python venv";
    }
  ];
}
