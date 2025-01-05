{...}: {
  networking = {
    hostName = "voyager";
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
