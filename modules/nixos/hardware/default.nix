{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.hardware;
in {
  imports = [
    ./network-printing.nix
    ./nvidia.nix
    ./storage.nix
  ];
  options.internal.modules.hardware = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.hardware.network-printing.enable = lib.mkDefault true;
  };
}
