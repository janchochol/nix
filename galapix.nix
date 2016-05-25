with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "galapix-0.2.1";

  src = fetchurl {
    url = "https://github.com/Galapix/galapix/archive/v0.2.1.tar.gz";
    sha256 = "1fhiai47r17hrhh782s8i8mlhbg1w14v6j5f64y5da1p9vaab3sa";
  };
  preConfigure = ''
    sed "109 a \\        self.env = Environment(ENV = os.environ, CPPPATH=['src'])" -i SConscript
    sed "s|-I/-isystem|-I\\\\//-isystem\\\\/|" -i SConscript
    sed "/GALAPIX_GTK/ s/True/False/" -i SConscript
    sed "1 i #include <string.h>" -i src/plugins/png.cpp
    sed "s/isnan/std::isnan/" -i src/galapix/workspace.cpp
  '';

  buildPhase = "scons";

  installPhase = ''
    mkdir -p $out/bin
    cp build/galapix.sdl $out/bin
  '';

  buildInputs = [ scons boost libexif sqlite libjpeg glew pkgconfig SDL imagemagick curl ];

  meta = with stdenv.lib; {
    description = "A zoomable image viewer for large collections of images";
    homepage    = https://github.com/Galapix/galapix;
    platforms   = platforms.all;
  };
}
