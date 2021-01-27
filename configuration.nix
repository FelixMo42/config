{ config, pkgs, ... } :

let
	dwm = pkgs.callPackage ./dwm {};
	st = pkgs.callPackage ./st {};
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	# Set up shell
	programs.fish.enable = true;
	users.users.felix = {
		shell = pkgs.fish;
	};

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable networking
	networking.hostName = "felixia"; # Define your hostname.
	networking.networkmanager.enable = true; # Enables wireless support via wpa_supplicant.

	# Set your time zone.
	time.timeZone = "America/Los_Angles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	# Enable the desktop environment.
	services.xserver.enable = true;
	services.xserver.desktopManager.xterm.enable = false;
	services.xserver.displayManager.lightdm.enable = true;
	services.xserver.windowManager.session = [{
		name = "dwm";
		start = "${dwm}/bin/dwm & waitPID=$!";
	}];

	# Make a nicer status bar
	systemd.user.services.dwm-status = {
		description = "dwm status";
		
		serviceConfig.ExecStart =
			let configFile = pkgs.writeText "dwm-status.toml" (builtins.readFile ./dwm/status.toml);
			in "${pkgs.dwm-status}/bin/dwm-status ${configFile}";

		wantedBy = [ "graphical-session.target" ];
		partOf   = [ "graphical-session.target" ];
	};

	# Configure keymap in X11
	services.xserver.layout = "us";
	services.xserver.xkbOptions = "eurosign:e";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

	# Enable touchpad support.
	services.xserver.libinput.enable = true;

	# Define a user account.
	users.users.felix = {
		isNormalUser = true;
		extraGroups = [
			"wheel" # let us use sudo
			"networkmanager" # let us edit network connection
		];
	};

	# Install packages
	environment.systemPackages = with pkgs; [
		neovim
		firefox
		st
		dwm
		dmenu
		git
		htop
		fish
		dwm-status
		upower
	];

	# Install fonts
	fonts.fonts = with pkgs; [
		nerdfonts
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	system.stateVersion = "20.09"; # Did you read the comment?
}

