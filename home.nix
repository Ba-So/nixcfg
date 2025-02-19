{ config, pkgs, epkgs, lib, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  sources = import ./nix/sources.nix;
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./overlays-home.nix
    ./modules/git.home.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "baso";
    homeDirectory = "/home/baso";
    packages = with pkgs; [];
  };
  
  services = {

    unclutter = {
      enable = true;
      timeout = 5;
    };

    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";
    }; 

    gpg-agent = {
      enable = true;
      maxCacheTtl = 864000;
      defaultCacheTtl = 864000;
      enableSshSupport = false;
      pinentryPackage = pkgs.pinentry-qt;
      # pinentryFlavor = null;
      # extraConfig = ''
      #   pinentry-program ${localPkgs.anypinentry}/bin/anypinentry
      # '';
    };
  };
  

  systemd.user.services.udiskie = {
    Install.WantedBy = lib.mkForce [ "default.target" ];
    Unit.After = lib.mkForce [ "udisks2.service" ];
  };

  programs = {
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_DIR = "~/.config/password-store";
      };
    };

    neovim.plugins = [
      pkgs.vimPlugins.nvim-treesitter
    ];

    gpg = {
      enable = true;
    };

  };


  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/zsh" = {
      source = ./config/zsh;
      recursive = true;
    };
    ".config/x11" = {
      source = ./config/x11;
      recursive = true;
    };
    ".xprofile" = {
      source = ./config/x11/xprofile;
    };
    ".zshrc" = {
      source = ./config/zsh/zshrc;
    };
    ".local/bin" = {
      source = ./config/scripts;
      recursive = true;
    };
    ".gconf.path" = {
      text = "xml:readonly:$(HOME)/.nix-profile/etc/gconf/gconf.xml.defaults/";
    };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg.configFile = {
    astronvim = {
      onChange = "nvim --headless -c 'if exists(\":LuaCacheClear\") | :LuaCacheClear' +quitall";
      source = ./config/astronvim;
    };
    nvim = {
      onChange = "nvim --headless -c 'if exists(\":LuaCacheClear\") | :LuaCacheClear' +quitall";
      source = sources.template; 
    };
  };
}
