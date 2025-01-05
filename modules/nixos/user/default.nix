{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.internal.modules.user;
in {
  options = {
    internal.modules.user.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${config.internal.settings.username} = {
      isNormalUser = true;
      description = config.internal.settings.fullName;
      extraGroups = [
        "wheel"
      ];
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;
  };
}
