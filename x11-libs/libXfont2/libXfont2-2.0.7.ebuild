# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X.Org Xfont2 library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libXfont2"
SRC_URI="https://www.x.org/releases/individual/lib/libXfont2-2.0.7.tar.xz -> libXfont2-2.0.7.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="bzip2 ipv6 truetype"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libfontenc
	x11-libs/xtrans
	bzip2? ( app-arch/bzip2 )
	truetype? ( media-libs/freetype )
	
	
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
$(use_with bzip2)
$(use_enable truetype freetype)
--without-fop
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
