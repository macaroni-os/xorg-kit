# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="
https://download.sourceforge.net/libpng/libpng-1.6.52.tar.xz -> libpng-1.6.52.tar.xz
apng? ( https://download.sourceforge.net/apng/libpng-1.6.51-apng.patch.gz -> libpng-1.6.51-apng.patch.gz )"
SLOT="0"
KEYWORDS="*"
IUSE="apng cpu_flags_x86_sse neon static-libs"
RDEPEND="sys-libs/zlib
	
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	
"
src_prepare() {
	default
	if use apng; then
	  sed -i -e 's|1.6.51|1.6.52|g' "${WORKDIR}"/${PN}-*-apng.patch || die
	  eapply -p0 "${WORKDIR}"/${PN}-*-apng.patch
	  sed -i -e '/^check/s:scripts/symbols.chk::' Makefile.in || die
	fi
	elibtoolize
}
src_configure() {
	local myeconfargs=(
	  $(use_enable cpu_flags_x86_sse intel-sse)
	  $(use_enable static-libs static)
	  --enable-arm-neon=$(usex neon)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
src_install() {
	default
	DOCS=( ANNOUNCE CHANGES libpng-manual.txt README TODO )
	einstalldocs
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
