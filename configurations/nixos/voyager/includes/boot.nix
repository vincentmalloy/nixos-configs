{...}: {
  boot = {
    plymouth.enable = true;
    supportedFilesystems = ["ntfs"];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      efi.efiSysMountPoint = "/boot/grub";
    };
  };
}
