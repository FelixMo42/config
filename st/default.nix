{ lib, stdenv, fetchurl, fetchpatch, pkg-config, writeText, libX11, ncurses, libXft } :

with lib;

let
	patches = [
		(fetchpatch {
			url = "https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff";
			sha256 = "14iamv53dc4pljyg0vaz07ksq8xgjc55xn7cn0zn590ah2xq23jy";
		})
	];
in stdenv.mkDerivation rec {
	pname = "st";
	version = "0.8.4";

	src = fetchurl {
		url = "https://dl.suckless.org/st/${pname}-${version}.tar.gz";
		sha256 = "19j66fhckihbg30ypngvqc9bcva47mp379ch5vinasjdxgn3qbfl";
	};
	
	inherit patches;
	
	configFile = writeText "config.def.h" (builtins.readFile ./config.h);
	
	postPatch = "cp ${configFile} config.def.h";

	nativeBuildInputs = [ pkg-config ncurses ];

	buildInputs = [ libX11 libXft ];

	installPhase = ''
		TERMINFO=$out/share/terminfo make install PREFIX=$out
	'';
}
