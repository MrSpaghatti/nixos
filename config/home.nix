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

		# ====== Theming ======
		gtk = {
			enable = true;
			theme = {
				name = "Nordic-darker";
				package = pkgs.nordic;
			};
			iconTheme = {
				name = "Tela-circle-nord";
				package = pkgs.tela-circle-icon-theme;
			};
			cursorTheme = {
				name = "Adwaita";
				package = pkgs.adwaita-icon-theme;
			};
            font = {
                name = "Noto Sans";
                size = 10;
            };
		};

		qt = {
			enable = true;
			platformTheme.name = "gtk";
		};

        # ====== Dotfiles ======
        home.file = {
            ".config/sway/config".source = ./../dotfiles/sway/config;
            ".config/sway/config.d/application_defaults".source = ./../dotfiles/sway/config.d/application_defaults;
            ".config/sway/config.d/autostart_applications".source = ./../dotfiles/sway/config.d/autostart_applications;
            ".config/sway/config.d/cheatsheet_hint".source = ./../dotfiles/sway/config.d/cheatsheet_hint;
            ".config/sway/config.d/default".source =
              let
                configFile = ./../dotfiles/sway/config.d/default;
              in
              pkgs.runCommand "sway-default-config" { } ''
                substitute ${configFile} $out \
                  --replace "@foot_client_path@" "${pkgs.foot}/bin/foot"
              '';
            ".config/sway/config.d/input".source = ./../dotfiles/sway/config.d/input;
            ".config/sway/config.d/output".source = ./../dotfiles/sway/config.d/output;
            ".config/sway/config.d/swayfx".source = ./../dotfiles/sway/config.d/swayfx;
            ".config/sway/config.d/theme".source = ./../dotfiles/sway/config.d/theme;
            ".config/sway/scripts/advance_workspace.sh" = { source = ./../dotfiles/sway/scripts/advance_workspace.sh; executable = true; };
            ".config/sway/scripts/bluetooth_toggle.sh" = { source = ./../dotfiles/sway/scripts/bluetooth_toggle.sh; executable = true; };
            ".config/sway/scripts/cheatsheet_hint.sh" = { source = ./../dotfiles/sway/scripts/cheatsheet_hint.sh; executable = true; };
            ".config/sway/scripts/hidpi_1.5.sh" = { source = ./../dotfiles/sway/scripts/hidpi_1.5.sh; executable = true; };
            ".config/sway/scripts/import-gsettings" = { source = ./../dotfiles/sway/scripts/import-gsettings; executable = true; };
            ".config/sway/scripts/screenshot_display.sh" = { source = ./../dotfiles/sway/scripts/screenshot_display.sh; executable = true; };
            ".config/sway/scripts/screenshot_window.sh" = { source = ./../dotfiles/sway/scripts/screenshot_window.sh; executable = true; };
            ".config/sway/scripts/swayfader.py" = { source = ./../dotfiles/sway/scripts/swayfader.py; executable = true; };
            ".config/waybar/config".source =
              let
                configFile = ./../dotfiles/waybar/config;
              in
              pkgs.runCommand "waybar-config" { } ''
                substitute ${configFile} $out \
                  --replace "@sh_path@" "${pkgs.bash}/bin/sh" \
                  --replace "@keyhint_sh_path@" "${config.home.homeDirectory}/.config/waybar/scripts/keyhint.sh"
              '';
            ".config/waybar/style.css".source = ./../dotfiles/waybar/style.css;
            ".config/waybar/scripts/keyhint.sh" = {
                executable = true;
                source = pkgs.runCommand "keyhint.sh" { } ''
                    substitute ${./../dotfiles/waybar/scripts/keyhint.sh} $out \
                        --replace "@yad_path@" "${pkgs.yad}/bin/yad"
                '';
            };
            ".config/foot/foot.ini".source =
              let
                configFile = ./../dotfiles/foot/foot.ini;
              in
              pkgs.runCommand "foot-ini" { } ''
                substitute ${configFile} $out \
                  --replace "@fish_path@" "${pkgs.fish}/bin/fish"
              '';
            ".config/fuzzel/fuzzel.ini".source = ./../dotfiles/fuzzel/fuzzel.ini;
            ".config/mako/config".source = ./../dotfiles/mako/config;
            ".config/nwg-drawer/drawer.css".source = ./../dotfiles/nwg-drawer/drawer.css;
            ".config/gtklock/config.ini".source = ./../dotfiles/gtklock/config.ini;
            ".config/gtklock/style.css".source = ./../dotfiles/gtklock/style.css;
            ".config/swayr/config.toml".source = ./../dotfiles/swayr/config.toml;
            ".config/swayr/waybar_config.toml".source = ./../dotfiles/swayr/waybar_config.toml;
            ".set-wallpaper.sh" = { source = ./../dotfiles/.set-wallpaper.sh; executable = true; };
        };

		# let home manager manage itself
		programs.home-manager.enable = true;
	};
}
