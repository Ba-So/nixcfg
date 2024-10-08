{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "bastian.sommerfeld@gmail.com";
    userName = "Bastian Sommerfeld";
    ignores = [
      "tags"
      ".vim.session"
      "tags.lock"
      "taks.temp"
    ];
    delta = {
      enable = true;
      options = {
        navigate = true;
	side-by-side = true;
	line-numbers = true;
      };
    };
    extraConfig = {
      color = {
        ui = true;
      };
      init = {
        defaultBranch = "main";
      };
      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
      "color \"diff\"" = {
        meta = 11;
        frag = "magenta bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
      pull = {
        rebase = false;
      };
      # pager = {
      #   diff = "${pkgs.delta}/bin/delta --color-only";
      # };
    };
  };

}
