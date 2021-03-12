{ lib, stdenv, fetchFromGitHub, coreutils, jdk11, maven, gradle } :

with lib;

stdenv.mkDerivation {
    name = "eclipse.jdt.ls";

    src = fetchFromGitHub {
        owner = "eclipse";
        repo = "lsp4j";
        rev = "8f509a4862f417731e10eea8582cb9807f67178f";
        sha256 = "0gsxd45fl4i2dhyc08lyjqpzkw3vzqjsmx24k43j9i1c7l4zywrn";
    };
    
    buildInputs = [ gradle ];

    buildPhase = ''
        patchShebangs gradlew
        export JAVA_HOME=$jdk11
        ./gradlew build
    '';

    inherit coreutils jdk11 maven;
}
