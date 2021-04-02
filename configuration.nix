{ config, pkgs, ... } :

let
    nvim = pkgs.callPackage ./nvim {};
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

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

    # Set up config
    programs.sway.enable = true;
    environment.etc = {
        "sway/config".source = ./sway/config;
    };

	# Install packages
	environment.systemPackages = with pkgs; [
		# applications
		firefox-wayland
        alacritty

        # terminal editors
        nvim
        amp

		# languages
		rustup  # rust
        jdk11   # java
        maven
        python3 # python
        nodejs  # js
        cmake   # c/c++
        dblatex # latex

        # utility
        git
        lazygit
        tokei
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

