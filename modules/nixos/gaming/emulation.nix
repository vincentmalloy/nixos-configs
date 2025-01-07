{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gaming.emulation;
in {
  options.internal.modules.gaming.emulation = {
    enable = lib.mkEnableOption "emulation software and settings";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (retroarch.withCores (_:
        with libretro; [
          flycast
        ]))
    ];
  };
}
