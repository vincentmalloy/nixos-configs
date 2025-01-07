{pkgs, ...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        indent.enable = true;
        hightlight.enable = true;
      };
      folding = false;
      nixvimInjections = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
    };
  };
}
