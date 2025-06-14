{pkgs, ...}: {
  services = {
    # gvfs.enable = true;
    # devmon.enable = true;
    udisks2.enable = true;
  };

  environment.systemPackages = with pkgs; [
    udiskie
  ];
}
