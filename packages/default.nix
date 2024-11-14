{ pkgs }:
{
  dmenu = pkgs.callPackage ./dmenu/pkg.nix { };
  dwmblocks = pkgs.callPackage ./dwmblocks/pkg.nix { };
  dwm = pkgs.callPackage ./dwm/pkg.nix { };
  st = pkgs.callPackage ./st/pkg.nix { };
}
