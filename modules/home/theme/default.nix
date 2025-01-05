{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.theme;
in {
  imports = [
    ./targets
  ];

  options.internal.modules.theme = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        wether to enable stylix theming module.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      opacity = {
        terminal = 0.8;
        applications = 1.0;
        desktop = 1.0;
      };
      fonts = {
        sizes = {
          terminal = 11;
          applications = 11;
        };
        monospace = {
          package =
            # nerd fonts moved in v25.05
            if pkgs ? nerd-fonts
            then pkgs.nerd-fonts.commit-mono
            else pkgs.nerdfonts.override {fonts = ["CommitMono"];};
          name = "CommitMono Nerd Font";
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
      };
    };
  };
}
