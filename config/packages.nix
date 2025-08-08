# /etc/nixos/config/packages.nix
# System-wide packages and fonts available to all users

{ config, lib, pkgs, ... }:

{
	# ====== Fonts ======
	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
		nerd-fonts.jetbrains-mono
		font-awesome
	];

	# ====== System Packages ======
	environment.systemPackages = with pkgs; [
		# Essentials
		foot #terminal emulator
		rofi-wayland # app launcher
		micro # cli text editor
		ox # tui text editor
		xfce.mousepad # gui text editor
		git
		wget
		unzip

		# File management
		xfce.thunar # file manager
		xfce.thunar-volman # auto-mount plugin
		xfce.thunar-archive-plugin # archive context menu
		gvfs # for automounting in file manager
		file-roller # archive manager

		# System & Wayland Utilities
		pavucontrol # pulseaudio volume control
		mpv # media player
		mako # notifs daemon
		swww # wayland wallpapers
		grim # screenshot tool
		slurp # region selector
		swappy # screenshot annotator
		wl-clipboard # cliboard tool
		cliphist # clipboard history manager
		kanshi # display profile manager
		swaylock-effects # screen locker
		btop # sysmon
		nix-search-cli # fast package searching
		meld # visual diff and merge tool

		# Shell & Prompt
		fish # shell
		starship # prompt
		eza # modern ls replacement
		tree # dir structure
		tlrc # tldr rust

		# Theming
		adwaita-icon-theme # default gtk icons
		dracula-theme # dracula gtk theme
		libsForQt5.breeze-qt5 # for theming qt5 apps
	];

	programs.fish.enable = true;
}
