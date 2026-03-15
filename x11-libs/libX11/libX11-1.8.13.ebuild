# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="X.Org X11 library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libX11"
SRC_URI="https://www.x.org/releases/individual/lib/libX11-1.8.13.tar.xz -> libX11-1.8.13.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="ipv6"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libxcb
	x11-misc/compose-tables
	!x11-libs/libxcb:0/1.12
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	x11-libs/xtrans
	
	
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
	  $(use_enable ipv6)
--without-fop
--with-keysymdefdir="${ESYSROOT}/usr/include/X11"
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	rm -rf "${ED}"/usr/share/X11/locale

}


# vim: filetype=ebuild
