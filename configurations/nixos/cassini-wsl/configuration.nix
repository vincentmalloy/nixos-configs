{
  inputs,
  config,
  homeModules,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.default
    (import ./disko.nix {device = "/dev/nvme0n1";})
    ./hardware-configuration.nix
    ./includes
  ];

  internal.modules.gui.enable = false;

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.05";
}
