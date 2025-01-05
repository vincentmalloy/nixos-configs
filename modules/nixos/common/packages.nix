{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.common.packages;
in {
  options.internal.modules.common.packages = {
    enable = lib.mkEnableOption "common nix packages installed on all systems";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      vim
      gnumake
    ];
  };
}
