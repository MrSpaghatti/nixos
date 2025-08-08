# /etc/nixos/configuration.nix
# This is the main entry point for your NixOS config.
# Imports all the other config files from the ./config/ dir.

{ config, lib, pkgs, ... }:

{
	imports = [
		# hardware-specific configs
		./hardware-configuration.nix

		# home manager for user-specific dotfiles and packages
		<home-manager/nixos>

		# import the rest of our modular configurations
		#./config/system.nix
		#./config/graphics.nix
		#./config/services.nix
		#./config/packages.nix
		#./config/user.nix
		#./config/home.nix

		/home/spag/conf/home.nix
		/home/spag/conf/user.nix
		/home/spag/conf/packages.nix
		/home/spag/conf/services.nix
		/home/spag/conf/graphics.nix
		/home/spag/conf/system.nix
	];

	system.stateVersion = "25.05";
}
