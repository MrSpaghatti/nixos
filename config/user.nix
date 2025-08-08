# /etc/nixos/config/user.nix
# User account definitions

{ config, lib, pkgs, ... }:

{
	# ====== User Account ======
	users.users.spag = {
		isNormalUser = true;
		description = "spag";
		extraGroups = [ "wheel" "networkmanager" "video" ];
		shell = pkgs.fish;
	};
}
