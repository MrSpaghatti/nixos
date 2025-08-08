# /etc/nixos/config/home.nix
# Home Manager config for spag user

{ config, lib, pkgs, ... }:

{
	home-manager.users.spag = {
		home.stateVersion = "25.05";

		home.username = "spag";
		home.homeDirectory = "/home/spag";

		# ====== User Specific Packages ======
		 home.packages = with pkgs; [
		#	discord
		#	spotify
			brave
			fzf
		];

		# ====== User Specific Configs ======
		programs.git = {
			enable = true;
			userName = "spag";
			userEmail = "ferretshiny@gmail.com";
		};

		programs.fish.enable = true;
		programs.starship.enable = true;

		wayland.windowManager.sway = {
			enable = true;
			config = rec {
				modififer = "Mod4"; # "Mod4" is the Super/Windows Key
				terminal = "${pks.foot}/bin/foot";
				menu = "${pkgs.rofi-wayland}/bin/rofi -show drun"
				startup = [
					{command = "mako";}
					{command = "waybar";}
				];

				keybindings = lib.mkOptionDefault {
					"Mod4+Return" = "exec ${config.programs.sway.config.terminal}"
				};
			};
		};

		# ====== Theming ======
		gtk = {
			enable = true;
			theme = {
				name = "Dracula";
				package = pkgs.dracula-theme;
			};
			iconTheme = {
				name = "Papirus";
				package = pkgs.papirus-icon-theme;
			};
			cursorTheme = {
				name = "Adwaita";
				package = pkgs.adwaita-icon-theme;
			};
		};

		qt = {
			enable = true;
			platformTheme = "gtk";
		};

		# let home manager manage itself
		programs.home-manager.enable = true;
	};
}
