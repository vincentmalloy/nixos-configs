{
  osConfig,
  config,
  ...
}: {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_lines.only_current_line = true;
      virtual_text = false;
    };
    plugins = {
      lsp-lines = {
        enable = true;
      };
      lsp-format = {
        enable = true;
      };
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          jsonls = {
            enable = true;
          }; # json
          nil_ls = {
            enable = false;
          };
          nixd = {
            enable = true;
            extraOptions = {
              options = {
                nixos = {
                  expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.${osConfig.networking.hostName}.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.${osConfig.networking.hostName}.home-manager.users.${config.home.username}.options";
                };
              };
            };
          }; # nix
        };
      };
    };
  };
}
