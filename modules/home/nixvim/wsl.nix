{
  lib,
  config,
  pkgs,
  ...
}: {
  disabledModules = [
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/web-devicons.nix
  ];

  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding = false;
        nixvimInjections = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };
      lsp-lines = {
        enable = true;
      };
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          jsonls = {
            enable = true;
          }; # json
          nil-ls = {
            enable = true;
          }; # nix
        };
      };
    };
  };
}
