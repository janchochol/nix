{ erlang }:
with import <nixpkgs> {}; # bring all of Nixpkgs into scope

stdenv.mkDerivation rec {
  version = "0.8.2";
  name = "meck-${version}";
  src = fetchurl {
    url = "https://github.com/eproxus/meck/archive/${version}.tar.gz";
    name = "${name}.tar.gz";
    sha256 = "dc1ad985b1c994c69b645f5cfd159bf9ba71d10a2984ce354500adb4ff0ae473";
  };

  unpackPhase = ''
    tar xzf $src
    cd $name
    sed -i 's/all: get-deps compile test doc/all: get-deps compile doc/' Makefile
  '';

  buildInputs = [ erlang git which ];

  installPhase = ''
    mkdir -p $out/lib/meck
    cp -r ebin $out/lib/meck/.
  '';

  meta = with stdenv.lib; {
    description = "A mocking library for Erlang";
    homepage = https://github.com/eproxus/meck;
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
