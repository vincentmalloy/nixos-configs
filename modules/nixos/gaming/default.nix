{config, lib, ...}:
let
  cfg = config.internal.modules.gaming;
in
{
  options.internal.modules.gaming = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  
  imports = [
    ./emulation.nix
    ./steam.nix
  ];

  config = lib.mkIf cfg.enable {
    internal.modules.gaming.emulation.enable = true;
    internal.modules.gaming.steam.enable = true;
  };
}
