{ erlang }:
with import <nixpkgs> {}; # bring all of Nixpkgs into scope

stdenv.mkDerivation rec {
  rev = "1febce3ca86c5ca5d5a3618ed3d5f125bb99e4c5";
  name = "jiffy-0.14.8";
  src = fetchurl {
    url = "https://github.com/davisp/jiffy/tarball/${rev}";
    name = "${name}.tar.gz";
    sha256 = "1kwd5fgb6fsmp7a4c56n1xdkn6h28s1cvnlhblxrx7papddav87x";
  };

  unpackPhase = ''
    tar xzf $src
    cd davisp-jiffy-1febce3
    sed -i "s/{vsn, git}/{vsn, \"0.14.8\"}/" src/jiffy.app.src
  '';

  buildInputs = [ erlang git ];

  installPhase = ''
    mkdir -p $out/lib/jiffy
    cp -r ebin $out/lib/jiffy/.
    cp -r priv $out/lib/jiffy/.
  '';

  meta = with stdenv.lib; {
    description = "JSON NIFs for Erlang";
    homepage = https://github.com/davisp/jiffy;
    license = licenses.bsd2;
    platforms = platforms.linux;
  };
}
