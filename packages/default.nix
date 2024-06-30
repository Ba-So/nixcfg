{ pkgs }:
{
  dmenu = pkgs.callPackage ./dmenu/pkg.nix { };
  dwm = pkgs.callPackage ./dwm/pkg.nix { };
  dwmblocks = pkgs.callPackage ./dwmblocks/pkg.nix { };
  st = pkgs.callPackage ./st/pkg.nix { };
}
