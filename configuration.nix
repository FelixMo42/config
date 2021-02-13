{ config, pkgs, ... } :

let
	dwm = pkgs.callPackage ./dwm {};
	st = pkgs.callPackage ./st {};
	neovim = pkgs.callPackage ./nvim {};
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

    # allow closed source software
    nixpkgs.config.allowUnfree = true;

    # 
    environment.variables.EDITOR = "nvim";

	# Set up shell
	programs.fish.enable = true;
	programs.fish.shellInit = builtins.readFile ./fish/init.fish;
	programs.fish.promptInit = builtins.readFile ./fish/prompt.fish;
	users.users.felix = { shell = pkgs.fish; };

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

    # Set up desktop
    programs.sway = {
        enable = true;
        extraPackages = with pkgs; [
            swaylock
            swayidle
            wl-clipboard
            mako
            alacritty
            dmenu
        ];
    };

    environment.etc = {
        "sway/config".source = ./sway/config;
    };

	# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

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
		# applications
		neovim
		firefox-wayland
        vscode
        discord
        zoom-us

		# languages
		rustup
		jdk11
		rnix-lsp

		# utility
		git
		htop
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

