with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "curl-7.43.0";

  src = fetchurl {
    url = "http://curl.haxx.se/download/${name}.tar.bz2";
    sha256 = "1ycdhp47v8z6y64s7ihi5jl28dzc5w8wqn0wrhy4hc152ahm99ms";
  };

  # Zlib and OpenSSL must be propagated because `libcurl.la' contains
  # "-lz -lssl", which aren't necessary direct build inputs of
  # applications that use Curl.
  propagatedBuildInputs = [ libidn openldap zlib openssl ];

  # for the second line see http://curl.haxx.se/mail/tracker-2014-03/0087.html
  preConfigure = ''
    sed -e 's|/usr/bin|/no-such-path|g' -i.bak configure
    rm src/tool_hugehelp.c
  '';

  # make curl honor CURL_CA_BUNDLE & SSL_CERT_FILE
  postConfigure = ''
    echo  '#define CURL_CA_BUNDLE (getenv("CURL_CA_BUNDLE") ? getenv("CURL_CA_BUNDLE") : getenv("SSL_CERT_FILE"))' >> lib/curl_config.h
  '';

  configureFlags = [
    "--with-ssl=${openssl}"
    "--enable-ldap"
    "--enable-ldaps"
    "--with-libidn=${libidn}"
    "--with-gssapi=${kerberos}"
  ];

  CXX = "g++";
  CXXCPP = "g++ -E";

#  crossAttrs = {
#    # We should refer to the cross built openssl
#    # For the 'urandom', maybe it should be a cross-system option
#    configureFlags = [
#        "--with-ssl=${openssl.crossDrv}"
#        "--with-random /dev/urandom"
#      ];
#  };
#
#  passthru = {
#    inherit sslSupport openssl;
#  };

  meta = with stdenv.lib; {
    description = "A command line tool for transferring files with URL syntax";
    homepage    = http://curl.haxx.se/;
    maintainers = with maintainers; [ lovek323 ];
    platforms   = platforms.all;
  };
}
