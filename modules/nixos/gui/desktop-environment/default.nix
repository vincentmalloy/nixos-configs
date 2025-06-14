{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui.desktop-environment;
in {
  options.internal.modules.gui.desktop-environment = {
    enable = lib.mkEnableOption "Desktop environment (compositor and associated programs)";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland.enable = true; # compositor
    };
    services = {
      hypridle.enable = true;
    };
    environment.systemPackages = with pkgs; [
      wl-clipboard # clipboard
      wofi # app launcher
    ];
  };
}
