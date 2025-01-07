{
  lib,
  myLib,
  config,
  osConfig,
  inputs,
  ...
}: let
  nixvim-key = "nixvim";
    # if (myLib.isWSL osConfig)
    # then "nixvim-wsl"
    # else "nixvim";
in {
  imports =
    [
      inputs.${nixvim-key}.homeManagerModules.nixvim
      ./autocomplete.nix
      ./theme.nix
      ./options.nix
      ./keymaps.nix
      ./plugins
    ];
    # ++ lib.optionals (myLib.isWSL osConfig) [./wsl.nix];

  config = {
    programs.nixvim = {
      enable = true;
      globals.mapleader = " ";
      viAlias = true;
      vimAlias = true;
      extraConfigVim = ''
        set exrc
      '';
      extraConfigLua =
        /*
        lua
        */
        ''
        '';
    };
  };
}
