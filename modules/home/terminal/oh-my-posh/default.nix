{
  osConfig,
  config,
  lib,
  ...
}: {
  home.file = {
    "${config.xdg.configHome}/oh-my-posh/config.json".source = lib.mkForce ./config.json;
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    # enableBashIntegration = true;
    settings = "${config.xdg.configHome}/oh-my-posh/config.json";
  };
}
