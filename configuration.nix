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
	time.timeZone = "America/Los_Angeles";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

    # Set up desktop
    programs.sway.enable = true;
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
		# web browser
		firefox-wayland

        # terminal
        alacritty

        # terminal editors
        neovim
        amp

		# languages
		rustup  # rust
        jdk11   # java
        maven
        python3 # python
        nodejs  # js
        cmake   # c/c++
        dblatex # latex

		# project mangment
		git 
        lazygit
        tokei

        # system utility
        ripgrep 
        fzf
        htop 
    ];

	# Install fonts
	fonts.fonts = with pkgs; [
		nerdfonts
	];

    # Nixos version
	system.stateVersion = "20.09";
}

