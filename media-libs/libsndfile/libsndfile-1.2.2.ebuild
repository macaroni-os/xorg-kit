# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="C library for reading and writing files containing sampled sound"
HOMEPAGE="https://libsndfile.github.io/libsndfile/ https://github.com/libsndfile/libsndfile"
SRC_URI="https://api.github.com/repos/libsndfile/libsndfile/tarball/1.2.2 -> libsndfile-1.2.2-72f6af1.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="alsa +external-libs static-libs"
RESTRICT="test"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="alsa? ( media-libs/alsa-lib:= )
	external-libs? (
		media-libs/flac:=
		media-libs/libogg:=
		media-libs/libvorbis:=
		media-libs/opus:=
	)
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv libsndfile-libsndfile-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DBUILD_EXAMPLES=OFF
	  -DBUILD_PROGRAMS=ON
	  -DBUILD_REGTEST=OFF
	  -DBUILD_SHARED_LIBS=$(usex !static-libs ON OFF)
	  -DBUILD_TESTING=OFF
	  -DENABLE_EXTERNAL_LIBS=$(usex external-libs ON OFF)
	  # MPEG codecs need media-sound/mpg123 >= 1.26 (tree has
	  # 1.25.10 which fails to build with gcc >= 14); re-enable
	  # once mpg123 is updated, macaroni-os/mark-issues#798
	  -DENABLE_MPEG=OFF
	)
	cmake_src_configure
}



# vim: filetype=ebuild
