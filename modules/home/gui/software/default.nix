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
    ./kitty.nix
  ];

  options.internal.modules.gui.software = {
    enable = lib.mkEnableOption "home manager modules for gui software";
  };

  config = lib.mkIf cfg.enable {
    internal.modules.gui.software.spotify.enable = lib.mkDefault true;
    internal.modules.gui.software.firefox.enable = lib.mkDefault true;
    internal.modules.gui.software.kitty.enable = lib.mkDefault true;
  };
}
