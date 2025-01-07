{
  lib,
  config,
  ...
}: {
  programs.nixvim = {
    keymaps =
      [
        {
          mode = "n";
          key = "<leader>m";
          options.silent = true;
          action = "<cmd>!make<CR>";
        }
      ]
      ++ lib.optionals config.programs.nixvim.plugins.lsp-lines.enable [
        {
          mode = "n";
          key = "<leader>h";
          action.__raw = "require(\"lsp_lines\").toggle";
          options.desc = "Toggle lsp_lines";
        }
      ];
  };
}
