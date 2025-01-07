{
  config,
  pkgs,
  ...
}: {
  users.users.${config.internal.settings.username} = {
    initialPassword = "1";
    packages = with pkgs; [
      nextcloud-client
      keepassxc
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.displayManager.autoLogin = {
    user = config.internal.settings.username;
  };
}
