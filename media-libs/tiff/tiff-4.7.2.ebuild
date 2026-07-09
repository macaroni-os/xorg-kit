# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools libtool

DESCRIPTION="Tag Image File Format (TIFF) library"
HOMEPAGE="http://libtiff.maptools.org"
SRC_URI="https://download.osgeo.org/libtiff/tiff-4.7.2.tar.xz -> tiff-4.7.2.tar.xz"
LICENSE="libtiff"
SLOT="0"
KEYWORDS="*"
IUSE="+cxx jbig jpeg lzma static-libs webp zlib zstd"
RDEPEND="jbig? ( media-libs/jbigkit:= )
	jpeg? ( virtual/jpeg )
	lzma? ( app-arch/xz-utils )
	webp? ( media-libs/libwebp:= )
	zlib? ( sys-libs/zlib )
	zstd? ( app-arch/zstd:= )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	eautoreconf
}
src_configure() {
	local myeconfargs=(
	  --without-x
	  --with-docdir="${EPREFIX}"/usr/share/doc/${PF}
	  $(use_enable cxx)
	  $(use_enable jbig)
	  $(use_enable jpeg)
	  $(use_enable lzma)
	  $(use_enable static-libs static)
	  $(use_enable webp)
	  $(use_enable zlib)
	  $(use_enable zstd)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
src_install() {
	default
	find "${ED}" -type f -name '*.la' -delete || die
}


# vim: filetype=ebuild
