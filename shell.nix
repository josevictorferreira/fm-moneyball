{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_4
    libffi
    openssl
    libxml2
    libxslt
    zlib
    wget
    curl
    gnumake
    libyaml
    watchman
  ];

  shellHook = ''
    export BUNDLE_PATH=$PWD/.bundle
    export GEM_HOME=$PWD/.bundle
    export PATH="$PWD/.bundle/bin:$PWD/bin:$PATH"
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath (with pkgs; [ curl openssl libffi libxml2 libxslt zlib libyaml ])};
    export RUBY_YJIT_ENABLE=1;
    export TMPDIR=/tmp
  '';
}
