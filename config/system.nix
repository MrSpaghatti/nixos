# /etc/nixos/config/system.nix
# basic system settings: bootloader, networking, time, locale, etc.

{ config, lib, pkgs, ... }:

{
	# ====== Bootloader ======
	# Use the systemd-boot EFI boot loader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# ====== Networking ======
	networking.hostName = "bruce";
	networking.networkmanager.enable = true;

	# ====== Time & Location ======
	time.timeZone = "America/Chicago";
	i18n.defaultLocale = "en_US.UTF-8";

	# ====== Nix Settings ======
	# Enable experimental features for flakes and the new nix command
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
