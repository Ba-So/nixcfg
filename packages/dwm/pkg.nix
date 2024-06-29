{ stdenv, pkgs, libX11, libXinerama, libXft}:
with pkgs.lib;

stdenv.mkDerivation rec{
name = "local-dwm-${version}";
	version = "6.4.x";

	src = ./source:;

	buildInputs = [libX11 libXinerama libXft];

	unpackPhase = ''cp -r $src/* .'';

	unpackPhase = ''make clean dwm'';

	installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
