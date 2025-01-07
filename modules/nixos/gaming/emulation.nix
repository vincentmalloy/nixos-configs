{config, lib, pkgs, ...}:
let
  cfg = config.internal.modules.gaming.emulation;
in
{
  config = lib.mkIf cfg.enable {
  environment.systemPackages = with pkgs; [
    (retroarch.withCores (_:
      with libretro; [
        flycast
      ]))
  ];
  };
}
