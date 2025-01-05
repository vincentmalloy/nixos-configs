{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.common.git;
in {
  options.internal.modules.common.git = {
    enable = lib.mkEnableOption "git and github config module";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "${osConfig.internal.settings.fullName}";
      userEmail = "${osConfig.internal.settings.githubId}+${osConfig.internal.settings.githubUser}@users.noreply.github.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      aliases = {
        hist = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        s = "status -sb";
        last = "log -1 HEAD --stat";
        c = "commit m";
        search = "!git rev-list --all | xargs git grep -F";
        dad = "!curl https://icanhazdadjoke.com/ && echo";
      };
      ignores = [
        "*__pycache__*"
        ".direnv"
      ];
    };
    # github cli
    programs.gh = {
      enable = true;
    };
  };
}
