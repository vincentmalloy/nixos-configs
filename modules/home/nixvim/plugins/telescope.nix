{...}: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        file-browser = {
          enable = true;
        };
        fzf-native = {
          enable = true;
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "find_files";
          options = {
            desc = "Find project files";
          };
        };
      };
    };
  };
}
