{lib, stdenv, fetchurl, fetchpatch, libX11, libXinerama, libXft, writeText}:

with lib;

let
	name = "dwm-6.2";
	patches = [
		(fetchpatch {
			url = "https://dwm.suckless.org/patches/notitle/dwm-notitle-6.2.diff";
			sha256 = "0hfmxblpzaxzcggvmil79wggqca27sli1qj0xwwqivs4vkp3d70l";
		})
	];
in stdenv.mkDerivation {
	inherit name;

	src = fetchurl {
		url = "https://dl.suckless.org/dwm/${name}.tar.gz";
		sha256 = "03hirnj8saxnsfqiszwl2ds7p0avg20izv9vdqyambks00p2x44p";
	};

	buildInputs = [ libX11 libXinerama libXft ];

	prePatch = ''sed -i "s@/usr/local@$out@" config.mk'';

	# Allow users set their own list of patches
	inherit patches;

	# Allow users to set the config.def.h file containing the configuration
	postPatch =
		let configFile = writeText "config.def.h" (builtins.readFile ./config.h);
		in "cp ${configFile} config.def.h";
}

