# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
SRC_URI="https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.6.tar.xz -> xcb-util-cursor-0.1.6.tar.xz"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libxcb:=
	x11-libs/xcb-util-image
	x11-libs/xcb-util-renderutil
	
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	dev-util/gperf
	x11-base/xcb-proto
	x11-base/xorg-proto
	
	
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
	  --with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
