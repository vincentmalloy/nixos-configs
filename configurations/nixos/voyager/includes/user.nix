{ config, pkgs, ... }:
{
  users.users.${config.internal.settings.username} = {
    initialPassword = "1";
    packages = with pkgs; [
      nextcloud-client
      keepassxc
    ];
  };

  services.displayManager.autoLogin = {
    user = config.internal.settings.username;
  };
}
