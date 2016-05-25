{
  packageOverrides = pkgs: rec {
    galapix = import ./galapix.nix;
    curlKerberos = import ./curl.nix;
    erlangR15 = import ./erlang15.nix;
    yaws_eR15 = pkgs.yaws.override { erlang = erlangR15; };
#    cyrus_sasl = pkgs.stdenv.lib.overrideDerivation pkgs.cyrus_sasl (oldAttrs: {
#      buildInputs = [ pkgs.openssl pkgs.db pkgs.gettext pkgs.kerberos pkgs.pam ];
#      preConfigure = ''
#        configureFlagsArray=( --with-plugindir=$out/lib/sasl2
#                              --with-configdir=$out/lib/sasl2
#                              --with-saslauthd=/run/saslauthd
#                              --enable-gssapi=${pkgs.kerberos}
#                              --enable-login
#                              --with-gss_impl=mit
#                            )
#      '';
#    });
#    p11_kit = pkgs.stdenv.lib.overrideDerivation pkgs.p11_kit (oldAttrs: {
#      configureFlags = "--with-libtasn1";
#    });
  };

  allowUnfree = true;
  firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };
  chromium = {
    enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
    enablePepperPDF = true;
  };
  mplayer = {
    vdpauSupport = true;
  };
}
