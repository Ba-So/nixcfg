{ stdenv, pkgs, libX11, libXinerama, libXft, fontconfig, pkg-config, ncurses, harfbuzz }:
with pkgs.lib;

stdenv.mkDerivation rec{
  name = "local-dwm-${version}";
  version = "0.8.4";

  src = ./source;

  nativeBuildInputs = [ pkg-config harfbuzz ];
  buildInputs = [ libX11 libXft fontconfig ncurses ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''TERMINFO=$out/share/terminfo make PREFIX=$out DESTDIR="" install'';
}
