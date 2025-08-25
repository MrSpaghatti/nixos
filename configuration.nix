# /etc/nixos/configuration.nix
# This is the main entry point for your NixOS config.
# Imports all the other config files from the ./config/ dir.

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # hardware-specific configs
      # This file is not in the repository, so we assume it's in the default location.
      /etc/nixos/hardware-configuration.nix

      # home manager for user-specific dotfiles and packages
      <home-manager/nixos>
    ]
    ++ (map (p: ./config + "/${p}") [
      "system.nix"
      "graphics.nix"
      "services.nix"
      "packages.nix"
      "user.nix"
      "home.nix"
      "vnc.nix"
    ]);

	system.stateVersion = "25.05";

    home-manager.backupFileExtension = "backup";
}
