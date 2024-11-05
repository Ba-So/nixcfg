{ pkgs, config, lib, ...}:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = with localPkgs; [
    dwm
    dwmblocks
    st
    dmenu
  ];

  devPackages = with pkgs; [
    neovim
    direnv
    #Python
    python3
    pipx
    poetry
    gcc
    rustup
    docker
    docker-compose
  ];

  appPackages = with pkgs; [
    brave
    spotify
    sxiv
    zathura
    discord
    gnucash
    remmina
    calibre
    libreoffice
    texlive.combined.scheme-full
    keepassxc
    obsidian
    thunderbird
    #evolution
    paperwork
    ausweisapp
    ranger
    signal-desktop
  ];

  utilPackages = with pkgs; [
    git
    unzip
    curl
    wget
    killall
    htop
    pstree
    file
    bluez
    libnotify
    xwallpaper
    xdotool
    wineWowPackages.stable
    pkgs.steam-run

    pulsemixer

    dconf

    dunst
    
    ripgrep
    lazygit
    bottom
    gdu
    tree

    # X stuff
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    xorg.xkill
    xcompmgr
    arandr
    niv
  ];
in
{
  environment.systemPackages = devPackages ++ customPackages ++ appPackages ++ utilPackages;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
}
