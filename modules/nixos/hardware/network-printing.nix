{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.hardware.network-printing;
in {
  options.internal.modules.hardware.network-printing = {
    enable = lib.mkEnableOption "network printing settings";
  };

  config = lib.mkIf cfg.enable {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
