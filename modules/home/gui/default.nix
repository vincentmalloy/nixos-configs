{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.gui;
in {
  imports = [
    ./software
    ./desktop-environment
  ];

  options.internal.modules.gui = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to enable gui related modules.
      '';
    };
    terminal = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kitty;
      description = ''
        default terminal emulator
      '';
    };
    browser = lib.mkOption {
      type = lib.types.package;
      default = pkgs.firefox;
      description = ''
        default browser
      '';
    };
    launcher = lib.mkOption {
      type = lib.types.package;
      default = pkgs.wofi;
      description = ''
        default app launcher
      '';
    };
    fileManager = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nautilus;
      description = ''
        default file manager
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    internal.modules.gui.software.enable = lib.mkDefault true;
    internal.modules.gui.desktop-environment.enable = lib.mkDefault true;
  };
}
