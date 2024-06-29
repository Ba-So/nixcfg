{ stdenv, pkgs, libX11, libXinerama, libXft}:
with pkgs.lib;

stdenv.mkDerivation rec{
name = "local-dwmblocks-${version}";
	version = "0.1.0";

	src = ./source:;

	nativeBuildInputs = [ pkg-config ];
	buildInputs = [ libX11 ];

	unpackPhase = ''cp -r $src/* .'';

	unpackPhase = ''make'';

	installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
