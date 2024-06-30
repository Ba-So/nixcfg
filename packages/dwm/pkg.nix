{ stdenv, pkgs, libX11, libXinerama, libXft, harfbuzz, pkg-config }:
with pkgs.lib;

stdenv.mkDerivation rec{
name = "local-dwm-${version}";
	version = "6.4.x";

	src = ./source;

	buildInputs = [ libX11 libXinerama libXft pkg-config ];

	unpackPhase = ''cp -r $src/* .'';

	buildPhase = ''make clean dwm'';

	installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
