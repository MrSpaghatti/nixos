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

        programs.waybar = {
            enable = true;
            style = (builtins.readFile ./../dotfiles/waybar/style.css);
            settings = {
                layer = "top";
                position = "top";
                modules-left = [
                    "custom/launcher"
                    "sway/workspaces"
                    "sway/window"
                ];
                "custom/launcher" = {
                    format = "<span size='x-large'></span>";
                    on-click = "exec nwg-drawer";
                    tooltip = false;
                };
                "sway/workspaces" = {
                    disable-scroll = true;
                    all-outputs = true;
                    format = "{icon}";
                    format-icons = {
                        "3" = "3";
                        "4" = "4";
                        "5" = "5";
                        "6" = "6";
                        "7" = "7";
                        "8" = "8";
                        "9" = "9";
                        "10" = "10";
                    };
                };
                "sway/window" = {
                    format = "{}";
                    max-length = 120;
                    on-click = "swayr merge-config ~/.config/swayr/waybar_config.toml; swayr switch-workspace-or-window; swayr reload-config";
                };
                modules-center = [
                    "network"
                ];
                network = {
                    format-disabled = " Disabled";
                    format-wifi = " {bandwidthDownBits:>} 󰶡 {bandwidthUpBits:>} 󰶣";
                    "tooltip-format-wifi" = "ESSID: {essid}";
                    format-ethernet = "󰈀 {bandwidthDownBits:>} 󰶡 {bandwidthUpBits:>} 󰶣";
                    "tooltip-format-ethernet" = "{ifname}: {ipaddr}/{cidr}";
                    format-disconnected = " Disconnected";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_nmtui -e nmtui";
                    interval = 2;
                };
                modules-right = [
                    "privacy"
                    "group/updates"
                    "custom/keyboard-layout"
                    "group/resources"
                    "memory"
                    "wireplumber"
                    "battery"
                    "group/settings"
                    "clock"
                    "group/power"
                ];
                privacy = {
                    icon-spacing = 4;
                    icon-size = 18;
                    transition-duration = 250;
                    modules = [
                        {
                            type = "screenshare";
                            tooltip = true;
                            tooltip-icon-size = 24;
                        }
                        {
                            type = "audio-out";
                            tooltip = true;
                            tooltip-icon-size = 24;
                        }
                        {
                            type = "audio-in";
                            tooltip = true;
                            tooltip-icon-size = 24;
                        }
                    ];
                };
                "group/updates" = {
                    orientation = "inherit";
                    drawer = {
                        "transition-duration" = 500;
                        "children-class" = "updates-drawer";
                        "transition-left-to-right" = false;
                        "click-to-reveal" = false;
                    };
                    modules = [
                        "custom/updates"
                        "custom/pacman"
                    ];
                };
                "custom/updates" = {
                    format = "{icon}{0}";
                    return-type = "json";
                    format-icons = {
                        "has-updates" = " ";
                        "updated" = "";
                    };
                    "exec-if" = "which waybar-module-pacman-updates";
                    exec = "waybar-module-pacman-updates --no-zero-output --interval-seconds 5 --network-interval-seconds 300 --tooltip-align-columns";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_pacseek -e pacseek -ui";
                };
                "custom/pacman" = {
                    format = "󰮯";
                    "tooltip-format" = "L󰍽: Pacseek\nR󰍽: Upgrade";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_pacseek -e pacseek";
                    "on-click-right" = "${pkgs.foot}/bin/foot -T waybar_garuda-update -e bash -c 'garuda-update && (read -p \"Update complete. Press Enter to exit.\" && exit 0) || (read -p \"Update failed. Press Enter to exit.\" && exit 1)'";
                };
                "custom/keyboard-layout" = {
                    exec = "i=$(swaymsg -t get_inputs); echo \"$i\" | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4";
                    format = "";
                    "tooltip-format" = "L󰍽: cheatsheet\nLayout: {0}";
                    interval = 30;
                    signal = 1;
                    on-click = let
                        keyhintScript = pkgs.runCommand "keyhint.sh" { } ''
                            substitute ${./../dotfiles/waybar/scripts/keyhint.sh} $out \
                                --replace "@yad_path@" "${pkgs.yad}/bin/yad"
                        '';
                    in
                    "${pkgs.bash}/bin/sh ${keyhintScript}";
                };
                "group/resources" = {
                    orientation = "inherit";
                    drawer = {
                        "transition-duration" = 500;
                        "children-class" = "resources-drawer";
                        "transition-left-to-right" = true;
                        "click-to-reveal" = true;
                    };
                    modules = [
                        "cpu"
                        "temperature"
                        "disk"
                    ];
                };
                cpu = {
                    interval = 5;
                    format = " {usage}%";
                    states = {
                        warning = 70;
                        critical = 90;
                    };
                };
                temperature = {
                    "critical-threshold" = 80;
                    "format-critical" = " {temperatureC}°C";
                    format = " {temperatureC}°C";
                    "tooltip-format" = "  󰍽: s-tui\n {temperatureC}° Celsius\n{temperatureF}° Fahrenheit\n{temperatureK}° Kelvin";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_s-tui -e s-tui";
                };
                disk = {
                    interval = 600;
                    format = "󰋊 {percentage_used}%";
                    path = "/";
                    "tooltip-format" = "    󰍽: dua\nTotal: {total}\n Used: {used} ({percentage_used}%)\n Free: {free} ({percentage_free}%)";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_dua -e dua i /";
                };
                memory = {
                    interval = 5;
                    format = " {}%";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_btm -e btm";
                    states = {
                        warning = 70;
                        critical = 90;
                    };
                    "tooltip-format" = "        󰍽: btm\n   Memory: {total} GiB\n   In use: {used} GiB ({percentage}%)\nAvailable: {avail} GiB\n     Swap: {swapTotal} GiB\n   In use: {swapUsed} GiB ({swapPercentage}%)\nAvailable: {swapAvail} GiB";
                };
                wireplumber = {
                    format = "{icon} {volume}%";
                    format-muted = "󰝟 muted";
                    on-click = "pavucontrol";
                    "on-click-right" = "pamixer --toggle-mute";
                    format-icons = ["󰕿" "󰖀" "󰕾"];
                    "tooltip-format" = "L󰍽: pavucontrol\nR󰍽: Toggle mute\nNode: {node_name}";
                };
                battery = {
                    states = {
                        warning = 20;
                        critical = 10;
                    };
                    format = "{icon} {capacity}%";
                    format-charging = "{icon} {capacity}% ";
                    format-plugged = "{icon} {capacity}% ";
                    format-full = "{icon} {capacity}% ";
                    format-icons = ["" "" "" "" ""];
                    "tooltip-format" = "󰍽: battop\n{timeTo}";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_battop -e battop";
                };
                "group/settings" = {
                    orientation = "inherit";
                    drawer = {
                        "transition-duration" = 500;
                        "children-class" = "settings-drawer";
                        "transition-left-to-right" = true;
                        "click-to-reveal" = true;
                    };
                    modules = [
                        "custom/settings"
                        "idle_inhibitor"
                        "backlight"
                        "bluetooth"
                        "tray"
                    ];
                };
                "custom/settings" = {
                    format = "";
                    "tooltip-format" = "Settings";
                };
                idle_inhibitor = {
                    format = "{icon}";
                    format-icons = {
                        activated = " ";
                        deactivated = " ";
                    };
                    "tooltip-format-activated" = "Idle Inhibitor Activated";
                    "tooltip-format-deactivated" = "Idle Inhibitor Deactivated";
                };
                backlight = {
                    format = "{icon} {percent}%";
                    format-icons = ["󰄰" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
                    "tooltip-format" = "Backlight (Scroll): {percent:}%";
                    "on-scroll-down" = "brightnessctl -c backlight set 5%-";
                    "on-scroll-up" = "brightnessctl -c backlight set +5%";
                };
                bluetooth = {
                    format = "󰂯 {status}:{num_connections}";
                    "format-on" = "󰂯";
                    "format-off" = "󰂲";
                    "format-disabled" = "";
                    format-icons = ["󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈"];
                    "tooltip-format" = "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}";
                    "tooltip-format-connected" = "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}\nDevice---------------Address------------Battery\n{device_enumerate}";
                    "tooltip-format-enumerate-connected" = "{device_alias:<20} {device_address:<18}";
                    "tooltip-format-enumerate-connected-battery" = "{device_alias:<20.20} {device_address:<18.18} {icon} {device_battery_percentage}%";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_bluetui -e bluetui";
                    "on-click-right" = "~/.config/sway/scripts/bluetooth_toggle.sh";
                };
                tray = {
                    icon-size = 16;
                    spacing = 10;
                };
                clock = {
                    format = "󰅐 {:%OI:%M %p}";
                    on-click = "${pkgs.foot}/bin/foot -T waybar_calcurse -e calcurse";
                    "tooltip-format" = " {:%A %m/%d}\n\n<tt><small>{calendar}</small></tt>";
                    calendar = {
                        "on-scroll" = 1;
                        format = {
                            months = "<span color='#ffead3'><b>{}</b></span>";
                            days = "<span color='#ecc6d9'><b>{}</b></span>";
                            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                        };
                    };
                    actions = {
                        "on-scroll-up" = "shift_up";
                        "on-scroll-down" = "shift_down";
                    };
                };
                "group/power" = {
                    orientation = "inherit";
                    drawer = {
                        "transition-duration" = 500;
                        "children-class" = "power-drawer";
                        "transition-left-to-right" = true;
                    };
                    modules = [
                        "custom/power"
                        "custom/reboot"
                        "custom/reboot-uefi"
                        "custom/log-off"
                        "custom/suspend"
                        "custom/lock"
                    ];
                };
                "custom/power" = {
                    format = "⏻";
                    on-click = "systemctl poweroff";
                    "tooltip-format" = "Shutdown";
                };
                "custom/reboot" = {
                    format = "";
                    on-click = "systemctl reboot";
                    "tooltip-format" = "Reboot";
                };
                "custom/reboot-uefi" = {
                    format = "";
                    on-click = "systemctl reboot --firmware-setup";
                    "tooltip-format" = "Reboot to UEFI";
                };
                "custom/log-off" = {
                    format = "󰍃";
                    on-click = "swaymsg exit";
                    "tooltip-format" = "Log out";
                };
                "custom/suspend" = {
                    format = "󰤄";
                    on-click = "systemctl suspend";
                    "tooltip-format" = "Suspend";
                };
                "custom/lock" = {
                    format = "󰌾";
                    on-click = "gtklock";
                    "tooltip-format" = "Lock";
                };
            };
        };

        systemd.user.services.wayvnc = {
            Unit = {
                Description = "wayvnc server";
                After = [ "graphical-session.target" ];
                PartOf = "graphical-session.target";
            };
            Install = {
                WantedBy = [ "graphical-session.target" ];
            };
            Service = {
                ExecStart = "${pkgs.wayvnc}/bin/wayvnc 0.0.0.0";
                Restart = "always";
                RestartSec = 10;
            };
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
            ".config/sway/scripts/hidpi_1.5.sh" = { source = ./../dotfiles/sway/scripts/hidpi_1.5.sh; executable = true; };
            ".config/sway/scripts/import-gsettings" = { source = ./../dotfiles/sway/scripts/import-gsettings; executable = true; };
            ".config/sway/scripts/screenshot_display.sh" = { source = ./../dotfiles/sway/scripts/screenshot_display.sh; executable = true; };
            ".config/sway/scripts/screenshot_window.sh" = { source = ./../dotfiles/sway/scripts/screenshot_window.sh; executable = true; };
            ".config/sway/scripts/swayfader.py" = { source = ./../dotfiles/sway/scripts/swayfader.py; executable = true; };
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
