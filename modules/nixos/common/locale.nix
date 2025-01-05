{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.internal.modules.common.locale;
in {
  options.internal.modules.common.locale = {
    enable = lib.mkEnableOption "locale settings";
  };

  config = lib.mkIf cfg.enable {
    time.hardwareClockInLocalTime = true;
    time.timeZone = "Europe/Berlin";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    console = {
      keyMap = "us";
      earlySetup = true;
    };
  };
}
