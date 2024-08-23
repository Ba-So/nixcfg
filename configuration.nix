# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in
{
  imports = [ 
    # Include the results of the hardware scan.
    <home-manager/nixos>
    ./hardware-configuration.nix #/greatatuin/default.nix
    ./packages.nix
    ./overlays-system.nix
    ./modules/login.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  services.udisks2.enable = true;
  programs.dconf.enable = true;

  # Bluetooth Stuff
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.users.baso = { pkgs, ... }:{
    imports = [ ./home.nix ];
    home = { stateVersion = "23.05"; };
  };

  # Configure X11
  services.xserver = {
    layout = "de";
    xkbVariant = "neo";
    videoDrivers = [ "nvidia" ];
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
  };
  
  programs.slock.enable = true;
  
  programs.bash.shellAliases = {
    # To make Plots in GnuCash work
    # https://github.com/NixOS/nixpkgs/issues/288641
    gnucash="WEBKIT_DISABLE_COMOSITING_MODE=1 gnucash";
  };
  # Only needed for laptops
  # TODO: move elsewhere
  # services.libinput = {
  #  enable = false;
  #  touchpad = {
  #    tapping = false;
  #    naturalScrolling = false;
  #  };
  #};

  # Fonts
  fonts.packages = with pkgs; [
    # jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cozette
    noto-fonts-emoji
  ];

  # Enable sound.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Networking

  networking = {
    hostName = "GreatAtuin"; # Define your hostname.
    networkmanager.enable = true;
  };
  programs.nm-applet.enable = true;

  # Locale Stuff
  ## TODO: move elsewhere
  ## Set your time zone.
  time.timeZone = "Europe/Berlin";

  ## Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  ## Configure console keymap
  console.keyMap = "neo";

  ## Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = false;
      nvidiaSettings = true;
      # Modesetting is required
      modesetting.enable = true;
      powerManagement = {
        enable = false;
	finegrained = false;
      };
    };
  };

  environment.localBinInPath = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
