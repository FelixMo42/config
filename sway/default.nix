{ stdenv, pkgs, fetchFromGitHub,
  coreutils, findutils, gnugrep, gnused } :

pkgs.sway.overrideAttrs(self: rec {
    postInstall = ''
        cp config ~/.sway/config
    '';
})
