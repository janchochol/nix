let
  pkgs = import <nixpkgs> {};
  jiffy_eR15 = import ../jiffy.nix { erlang = pkgs.erlangR15; };
  meck_eR15 = import ../meck.nix { erlang = pkgs.erlangR15; };
  yaws_eR15 = import ../yaws.nix { erlang = pkgs.erlangR15; };
  stdenv = pkgs.stdenv;
in rec {
  erlEnv = stdenv.mkDerivation rec {
    name = "erlang-env";
    version = "R15";
    src = ./.;
    buildInputs = [ pkgs.gdb pkgs.erlangR15 yaws_eR15 jiffy_eR15 meck_eR15 ];
    ERL_LIBS="${yaws_eR15}/lib:${jiffy_eR15}/lib:${meck_eR15}/lib";
  };
}
