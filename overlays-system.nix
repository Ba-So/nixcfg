# Overlays for the system-scope https://nixos.wiki/wiki/Overlays
# Nothing here yet
{ pkgs, ... }:
let
  overlays = import ./overlays/default.nix { };
in
{
  nixpkgs.overlays = with overlays; [
    pass-with-dmenu
  ];
}
