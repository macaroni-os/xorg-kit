# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X.Org compose-tables library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/compose-tables"
SRC_URI="https://www.x.org/releases/individual/lib/libX11-1.8.13.tar.xz -> libX11-1.8.13.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libxcb
	
	
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
S="${WORKDIR}/libX11-1.8.13"

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
	  --without-fop
--without-xmlto
--without-fop
--disable-specs
--disable-xkb
	 )
	econf "${econfargs[@]}"
}
src_compile() {
	emake -C nls
}
src_install() {
	emake DESTDIR="${D}" -C nls install
	find "${D}" -type f -name '*.la' -delete || die
}


# vim: filetype=ebuild
