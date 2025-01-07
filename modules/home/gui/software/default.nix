{
  config,
  lib,
  ...
}: let
  cfg = config.internal.modules.gui.software;
in {
  imports = [
    ./spotify.nix
    ./firefox.nix
  ];

  options.internal.modules.gui.software = {
    enable = lib.mkEnableOption "home manager modules for gui software";
  };

  config = lib.mkIf cfg.enable {
    internal.modules.gui.software.spotify.enable = lib.mkDefault true;
    internal.modules.gui.software.firefox.enable = lib.mkDefault true;

    programs.kitty = {
      enable = true;
      extraConfig = ''
        modify_font cell_height 110%
      '';
    };
  };
}
