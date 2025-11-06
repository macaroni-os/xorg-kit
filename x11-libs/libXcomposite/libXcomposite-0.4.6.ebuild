# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X.Org Xcomposite library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libXcomposite"
SRC_URI="https://www.x.org/releases/individual/lib/libXcomposite-0.4.6.tar.xz -> libXcomposite-0.4.6.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libX11
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	x11-libs/libXfixes
	
	
"

src_prepare() {
	eautoreconf || die
	default
}
src_configure() {
	local no_static=""
	# Check if package supports disabling of static libraries
	if grep -q -s "able-static" ${ECONF_SOURCE:-.}/configure; then
	  no_static="--disable-static"
	fi
	local econfargs=(
	  --enable-shared
	  ${no_static}
	  
	)
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
