let
  pkgs = import <nixpkgs> {};
  jiffy_eR17 = import ../jiffy.nix { erlang = pkgs.erlangR17; };
  meck_eR17 = import ../meck.nix { erlang = pkgs.erlangR17; };
  yaws_eR17 = import ../yaws.nix { erlang = pkgs.erlangR17; };
  stdenv = pkgs.stdenv;
in rec {
  erlEnv = stdenv.mkDerivation rec {
    name = "erlang-env";
    version = "R17";
    src = ./.;
    buildInputs = [ pkgs.gdb pkgs.erlangR17 yaws_eR17 jiffy_eR17 meck_eR17 ];
    ERL_LIBS="${yaws_eR17}/lib:${jiffy_eR17}/lib:${meck_eR17}/lib";
  };
}
