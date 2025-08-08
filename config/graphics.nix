# /etc/nixos/config/graphics.nix
# All settings related to the GUI
# Window Manager, Display Manager, Panel, Theming, etc.

{ config, lib, pkgs, ... }:

{
	# ====== Window Manager ======
	programs.sway = {
		enable = true;
		package = pkgs.swayfx;
		wrapperFeatures.gtk = true; 
	};

	# ====== Panel ======
	programs.waybar.enable = true;

	# ====== Browser ======
	#programs.brave.enable = true;

	# ====== Login Manager ======
	services.greetd = {
		enable = true;
		vt = 1;
		settings = {
			default_session = {
				command = "${pkgs.swayfx}/bin/sway";
				user = "spag";
			};
		};
	};

	# ====== Theming & Fonts ======
}
