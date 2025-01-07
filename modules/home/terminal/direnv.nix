{config, lib, ...}:
let
  cfg = config.internal.modules.terminal.direnv;
in
{
  options.internal.modules.terminal.direnv = {
    enable = lib.mkEnableOption "direnv config";
  };
  
  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      DIRENV_LOG_FORMAT = "";
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
