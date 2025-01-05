{
  description = "Nixos System Configuration";

  inputs = {
    # primary flake inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";
    home-manager.url = "github:nix-community/home-manager";
    disko.url = "github:nix-community/disko";
    # impermanence.url = "github:nix-community/impermanence";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    # hyprpaper.url = "github:hyprwm/hyprpaper";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # inputs for nixos on wsl2
    nixpkgs-wsl.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager-wsl.url = "github:nix-community/home-manager/release-24.05";
    nixvim-wsl.url = "github:nix-community/nixvim/nixos-24.05";
    stylix-wsl.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";

    # formatter
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    treefmt-nix,
    ...
  }: let
    root = ./.;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      imports = [
        ./flake-parts/plumbing
        treefmt-nix.flakeModule
      ];

      internal.plumbing = {
        inherit root;
      };

      perSystem = {...}: {
        treefmt = import (root + /treefmt.nix);
      };
    };
}
