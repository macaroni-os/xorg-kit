# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION=""
SRC_URI="https://www.x.org/releases/individual/lib/libXScrnSaver-1.2.5.tar.xz -> libXScrnSaver-1.2.5.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	
	
"
DEPEND="sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	
"
src_prepare() {
	eautoreconf || die
	default
}
src_configure() {
	local econfargs=(
	  --enable-shared
	  
	)
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
}


# vim: filetype=ebuild
