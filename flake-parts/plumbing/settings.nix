# this submodule is imported in configurations
{
  lib,
  root,
  configRoot,
  ...
}: let
  inherit (builtins) pathExists;
  inherit (lib) mkOption mkDefault;
  inherit (lib.types) uniq str submodule path list;
in {
  options.internal.settings = mkOption {
    type = submodule {
      options = {
        root = mkOption {
          type = path;
          default = root;
        };
        configRoot = mkOption {
          type = path;
          default = configRoot;
        };
        username = mkOption {
          type = uniq str;
          description = ''
            default username, used for all nixos and home configurations if not specified otherwise
          '';
        };
        fullName = mkOption {
          type = uniq str;
          description = ''
            full name
          '';
        };
        githubUser = mkOption {
          type = uniq str;
          description = ''
            github username
          '';
        };
        githubId = mkOption {
          type = uniq str;
          description = ''
            github id number, used for git email
          '';
        };
        colorscheme = mkOption {
          type = uniq str;
          description = ''
            base16 colorscheme
          '';
        };
        disabledModules = mkOption {
          type = list;
          default = [];
        };
      };
    };
  };

  config = let
    settingsFile = root + /settings.nix;
    configSettingsFile = configRoot + /settings.nix;
  in {
    internal.settings =
      (
        if pathExists settingsFile
        then mkDefault (import settingsFile)
        else {}
      )
      // (
        if pathExists configSettingsFile
        then (import configSettingsFile)
        else {}
      );
  };
}
