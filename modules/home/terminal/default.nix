{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.terminal;
in {
  imports = [
    ./direnv.nix
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
  };
}
