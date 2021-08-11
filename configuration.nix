{ config, pkgs, ... } :

let
    use_wayland = true;

    # bring in custom packages
    nvim = pkgs.callPackage ./nvim {};
    python = pkgs.callPackage ./python {};
in {
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

    # Allow closed source software
    nixpkgs.config.allowUnfree = true;

	# Set up shell
	programs.fish.enable = true;
	programs.fish.shellInit = builtins.readFile ./fish/init.fish;
    programs.fish.promptInit = builtins.readFile ./fish/prompt.fish;
	users.users.felix = { shell = pkgs.fish; };
    
    # Adb for android stuff
    programs.adb.enable = true;

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

    # enable vulkan
    hardware.opengl.driSupport = true;

    # enable bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # power managment
    services.upower.enable = true;

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
            "adbusers" # lets use use abd
		];
	};

    

    programs.sway.enable = use_wayland;
    environment.etc = {
       "sway/config".source = ./sway/config;
    };

    services.xserver.enable = !use_wayland;
    services.xserver.desktopManager.xfce.enable = !use_wayland;

    # Lets play some games
    nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
            extraPkgs = pkgs: [
                pkgs.pipewire
            ];
        };
    };
    programs.steam.enable = true;

	# Install packages
	environment.systemPackages = with pkgs; [
		# applications
        firefox-wayland # browser
        alacritty       # terminal
        krita           # art tool
        minecraft       # minecraft
        zoom-us         # zoom
        teams           # microsoft teams

        # terminal applications
        nvim    # editor
        htop    # system monitor
        lazygit # git viewer
        fzf     # file searcher

        # utility
        git           # version controlle
        tokei         # project line counter
        ripgrep       # better grep
        brightnessctl # adjust screen brightness
        zip unzip     # zipping utilitys
        steamcmd      # steam tui stuff

		# languages
		rustup    # rust
        wasm-pack # wasm
        jdk11     # java
        python    # python
        nodejs    # js
        cmake     # c/c++
        dblatex   # latex
    ];

	# Install fonts
	fonts.fonts = with pkgs; [
		nerdfonts
	];

    # Nixos version
	system.stateVersion = "21.05";
}

