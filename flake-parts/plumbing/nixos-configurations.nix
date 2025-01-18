{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkDefault types mapAttrs mapAttrsToList;
  inherit (lib.strings) hasSuffix;

  cfg = config.internal.plumbing;

  configPath = cfg.root + /configurations/nixos;
  nixosModulesPath = cfg.root + /modules/nixos;
  homeModulesPath = cfg.root + /modules/home;

  homeConfigurationType = types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      standalone = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  nixosConfigurationType = types.submodule {
    options = {
      hostname = mkOption {
        type = types.str;
      };
      os = lib.mkOption {
        type = lib.types.str;
        default = "linux";
      };
      home-manager = mkOption {
        type = homeConfigurationType;
        default = cfg.lib.defaultSubmoduleAttr homeConfigurationType;
      };
    };
  };

  mkNixosConfigurations = nixosConfigurations:
    mapAttrs (
      hostname: configModule: let
        configuration =
          cfg.lib.defaultSubmoduleAttr nixosConfigurationType
          // (
            if cfg.configurations.nixos ? hostname
            then cfg.configurations.nixos.${hostname}
            else {}
          )
          // {
            inherit hostname;
          }
          // (
            if (lib.strings.hasSuffix hostname "-wsl")
            then {os = "wsl";}
            else {}
          );

        settingsFile = cfg.root + /settings.nix;
        configSettingsFile = cfg.root + /configurations/${hostname}/settings.nix;
        internal.settings =
          (
            if builtins.pathExists settingsFile
            then (import settingsFile)
            else {}
          )
          // (
            if builtins.pathExists configSettingsFile
            then (import configSettingsFile)
            else {}
          );

        osTargets = {
          linux = {
            systemBuilder =
              if inputs ? nixpkgs
              then inputs.nixpkgs.lib.nixosSystem
              else
                throw ''
                  nixpkgs input not found for linux system "${hostname}"
                '';
            home-manager =
              if inputs ? home-manager
              then inputs.home-manager.nixosModules.home-manager
              else
                throw ''
                  home-manager input not found for linux system "${hostname}"
                '';
            stylix =
              if inputs ? stylix
              then {
                nixos = inputs.stylix.nixosModules.stylix;
                home = inputs.stylix.homeManagerModules.stylix;
              }
              else
                throw ''
                  stylix input not found for linux system "${hostname}"
                '';
          };
          wsl = {
            systemBuilder =
              if inputs ? nixpkgs-wsl
              then inputs.nixpkgs-wsl.lib.nixosSystem
              else
                throw ''
                  nixpkgs input not found for wsl system "${hostname}"
                '';
            home-manager =
              if inputs ? home-manager-wsl
              then inputs.home-manager-wsl.nixosModules.home-manager
              else
                throw ''
                  home-manager input not found for wsl system "${hostname}"
                '';
            stylix =
              if inputs ? stylix-wsl
              then {
                nixos = inputs.stylix-wsl.nixosModules.stylix;
                home = inputs.stylix-wsl.homeManagerModules.stylix;
              }
              else
                throw ''
                  stylix input not found for wsl system "${hostname}"
                '';
          };
        };

        os =
          if configuration ? os
          then
            if osTargets ? "${configuration.os}"
            then osTargets.${configuration.os}
            else
              throw ''
                unknown target os ("$configuration.os")
              ''
          else
            throw ''
              no target os given to configuration for "${hostname}"
            '';

        defaultModules = [
          {networking.hostName = mkDefault configuration.hostname;}
          (import ./settings.nix {
            inherit lib config;
            inherit (cfg) root;
            configRoot = configPath + /${hostname};
          })
        ];
        additionalModules =
          lib.mapAttrsToList
          (n: v: v)
          config.flake.nixosModules
          ++ [inputs.nur.modules.nixos.default]
          ++ [os.stylix.nixos]
          ++ lib.optionals (configuration.home-manager.enable) [
            os.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs;};
                users.${internal.settings.username} = {...}: {
                  imports =
                    (lib.mapAttrsToList
                      (n: v: v)
                      config.flake.homeModules)
                    ++ [
                      (configPath + "/${hostname}" + /home.nix)
                      inputs.spicetify-nix.homeManagerModules.default
                      (import ./settings.nix {
                        inherit lib config;
                        inherit (cfg) root;
                        configRoot = configPath + /${hostname};
                      })
                    ];
                };
              };
            }
          ]
          ++ lib.optionals (configuration.os == "wsl") [
            inputs.nixos-wsl.nixosModules.default
            {internal.modules.gui.enable = false;}
          ];
      in
        os.systemBuilder {
          specialArgs = {
            inherit inputs;
            homeModules =
              lib.mapAttrsToList
              (n: v: v)
              config.flake.homeModules;
          };
          modules =
            [
              configModule
            ]
            ++ defaultModules
            ++ additionalModules;
        }
    )
    nixosConfigurations;
in {
  options.internal.plumbing = {
    configurations = mkOption {
      type = types.submodule {
        options = {
          nixos = mkOption {
            type = types.attrsOf (types.submodule nixosConfigurationType);
            default = {};
          };
        };
      };
      default = {};
    };
  };

  config = {
    flake.nixosConfigurations =
      mkNixosConfigurations
      (cfg.lib.readConfigurations configPath);
  };
}
