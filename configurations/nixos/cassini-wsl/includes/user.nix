{
  config,
  pkgs,
  ...
}: {
  users.users.${config.internal.settings.username} = {
    initialPassword = "1";
    packages = with pkgs; [
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
