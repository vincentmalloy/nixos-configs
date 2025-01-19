{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.terminal;
in {
  imports = [
    ./eza.nix
    ./oh-my-posh
    ./direnv.nix
    ./helix.nix
    ./yazi.nix
    ./zsh.nix
  ];

  options.internal.modules.terminal = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.terminal.direnv.enable = true;
    internal.modules.terminal.zsh.enable = true;

    programs.yazi.enable = true;
    programs.helix.enable = true;
    home.packages = [
      pkgs.aerc
    ];
  };
}
