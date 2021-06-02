{ pkgs } :

pkgs.python3.withPackages (python-packages: with python-packages; [
    # python utilities
    pip # python package manager
    pycodestyle # python linter and code formater

    # python libraries
    pyglet # game engine 
    pkgs.callPackage ./pros-cli {} # vex interface
])
