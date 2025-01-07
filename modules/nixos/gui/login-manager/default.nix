{
  pkgs,
  config,
  lib,
  ...
}: let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./tokyo-night-sddm.nix {inherit pkgs config;};
  cfg = config.internal.modules.gui.login-manager;
in {
  options.internal.modules.gui.login-manager = {
    enable = lib.mkEnableOption "graphical login manager";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager = {
      autoLogin.enable = true;
      sddm = {
        enable = true;
        wayland.enable = true;
        wayland.compositor = "kwin";
        theme = "tokyo-night-sddm";
      };
    };

    environment.systemPackages = [
      pkgs.libsForQt5.qtgraphicaleffects
      tokyo-night-sddm
    ];
  };
}
