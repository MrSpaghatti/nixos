# /etc/nixos/config/packages.nix
# System-wide packages and fonts available to all users

{ config, lib, pkgs, ... }:

{
	# ====== Fonts ======
	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		noto-fonts
		font-awesome
	];

	# ====== System Packages ======
	environment.systemPackages = with pkgs; [
		# Essentials
		foot #terminal emulator
		fuzzel # app launcher
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
		azote # wayland wallpapers
		grim # screenshot tool
		slurp # region selector
		swappy # screenshot annotator
		wl-clipboard # cliboard tool
		wl-paste
		cliphist # clipboard history manager
		kanshi # display profile manager
		gtklock # screen locker
		btop # sysmon
		meld # visual diff and merge tool
		jq
		swayidle
		brightnessctl
		pamixer
		playerctl
		autotiling
		dex
		swayrd
		python3

		# Shell & Prompt
		fish # shell
		starship # prompt
		eza # modern ls replacement
		tree # dir structure
		tlrc # tldr rust

		# Theming
		nordic
		tela-circle-icon-theme
		capitaine-cursors
		adwaita-icon-theme
		libsForQt5.breeze-qt5 # for theming qt5 apps
		nwg-launchers

		# Garuda extras
		# garuda-wallpapers # This package probably doesn't exist in nixpkgs
	];

	programs.fish.enable = true;
}
