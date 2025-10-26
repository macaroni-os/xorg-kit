# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X.Org ICE library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libICE"
SRC_URI="https://www.x.org/releases/individual/lib/libICE-1.1.2.tar.xz -> libICE-1.1.2.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="ipv6"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="|| (
	  sys-libs/glibc
	  dev-libs/libbsd
	)
	x11-libs/xtrans
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
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
	local no_static=""
	# Check if package supports disabling of static libraries
	if grep -q -s "able-static" ${ECONF_SOURCE:-.}/configure; then
	  no_static="--disable-static"
	fi
	local econfargs=(
	  --enable-shared
	  ${no_static}
	  $(use_enable ipv6)
--disable-docs
--disable-specs
--without-fop
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
