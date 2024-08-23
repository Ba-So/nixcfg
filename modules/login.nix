{ pkgs, ... }:
let
  sessions = [
    [ "tty1" windowManagers.dwm ]
  ];
  windowManagers = {
    dwm = looped "dwm";
  };
  exec = s: "exec ${s}";
  looped = s: ''
    while true; do
      ssh-agent ${s} || break;
    done
  '';
in
{
  users.groups = {
    uinput = { };
    storage = { };
  };
  # User
  users.users.baso = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "video"
      "storage"
      "git"
      "networkmanager"
      "docker"
      "transmission"
    ];
  };
  environment.shells = with pkgs; [ zsh bashInteractive ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histFile = "~/.config/zsh/zshhistory";
    histSize = 50000;
    interactiveShellInit = ''source ~/.config/zsh/zshrc'';
    promptInit = "";
    loginShellInit = "startx ~/.config/x11/xinitrc";
  };
  services = {
    getty = {
      autologinUser = "baso";
      helpLine = "";
      greetingLine = import ./welcome-text.nix;
    };
  };
}
