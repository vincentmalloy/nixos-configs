{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui.desktop-environment;
in {
  options.internal.modules.gui.desktop-environment = {
    enable = lib.mkEnableOption "Desktop environment (compositor and associated programs) home configuration";
  };

  imports = [
    inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
    ./hyprland
    # ./mako.nix
    # ./wofi.nix
    ./waybar.nix
  ];

  config = lib.mkIf cfg.enable {
    internal.modules.gui.desktop-environment.hyprland.enable = lib.mkDefault true;
    internal.modules.gui.desktop-environment.waybar.enable = lib.mkDefault true;

    #mako notifications
    services.mako = {
      enable = true;
      package = pkgs.mako;
      settings.defaultTimeout = 4000;
    };

    #wofi app launcher
    programs.wofi = {
      enable = true;
      settings = {
        allow_images = true;
        allow_markup = true;
        content_halign = "center";
      };
    };

    programs.hyprcursor-phinger.enable = true;
  };
}
