{...}: {
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      closeIfLastWindow = true;
      eventHandlers = {
        file_open_requested = ''
          function(_)
            vim.cmd("Neotree close")
          end
        '';
      };
    };
    keymaps = [
      {
        mode = ["n"];
        key = "<leader>e";
        action = ":Neotree action=focus reveal toggle <CR>";
        options = {
          desc = "Open/Close Neotree";
        };
      }
    ];
  };
}
