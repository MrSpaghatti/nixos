# /etc/nixos/config/services.nix
# System-wide services and daemons.

{ config, lib, pkgs, ... }:

{
	# ====== Core Services ======
	services.dbus.enable = true; # required for many apps to communicate
	security.polkit.enable = true; # privilege management

	# ====== Printing ======
	services.printing.enable = true; # enable CUPS

	# ====== Sound ======
	hardware.pulseaudio.enable = false; # avoid conflicts
	security.rtkit.enable = true; # real-time kernel scheduler for low-latency audio
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true; # pulseaudio compatible socket
	};

	# ====== SSH Daemon ======
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
			PermitRootLogin = "prohibit-password";
		};
	};
}
