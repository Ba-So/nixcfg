{ stdenv, pkgs, libX11, libXinerama, libXft}:
with pkgs.lib;

stdenv.mkDerivation rec{
name = "local-dwm-${version}";
	version = "0.8.4";

	src = ./source:;

	buildInputs = [ libX11 libXft fontconfig ncurses ];

	unpackPhase = ''cp -r $src/* .'';

	unpackPhase = ''make'';

	installPhase = ''TERMINFO=$out/share/teminfo make PREFIX=$out DESTDIR="" install'';
}
