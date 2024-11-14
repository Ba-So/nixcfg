# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  localPkgs = import ./packages/default.nix {pkgs = pkgs;};
in {
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

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = ["ntfs"];
  };

  services = {
    udisks2.enable = true;
    blueman.enable = true;
    # Configure X11
    xserver = {
      xkb = {
        layout = "de";
        variant = "neo";
      };
      videoDrivers = ["nvidia"];
      enable = true;
      autorun = false;
      displayManager.startx.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
  };

  programs = {
    dconf.enable = true;
    slock.enable = true;

    bash.shellAliases = {
      # To make Plots in GnuCash work
      # https://github.com/NixOS/nixpkgs/issues/288641
      gnucash = "WEBKIT_DISABLE_COMOSITING_MODE=1 gnucash";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.baso = {pkgs, ...}: {
      imports = [./home.nix];
      home = {stateVersion = "23.05";};
    };
  };

  users.users.baso.extraGroups = ["scanner" "lp" "docker"];

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
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    cozette
    noto-fonts-emoji
  ];

  # Enable sound.
  sound.enable = false;
  security.rtkit.enable = true;

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
  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
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
  };

  ## Configure console keymap
  console.keyMap = "neo";

  ## Enable CUPS to print documents.

  hardware = {
    sane = {
      enable = true;
      extraBackends = [pkgs.hplipWithPlugin];
    };
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
    pulseaudio.enable = true;
    # Bluetooth Stuff
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  virtualisation.docker.enable = true;

  environment.localBinInPath = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
