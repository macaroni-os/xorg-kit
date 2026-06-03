# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE=xml
inherit autotools flag-o-matic python-any-r1

DESCRIPTION="X.Org xcb library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libxcb"
SRC_URI="https://www.x.org/releases/individual/lib/libxcb-1.17.0.tar.xz -> libxcb-1.17.0.tar.xz"
LICENSE="MIT"
SLOT="0/1.12"
KEYWORDS="*"
IUSE="+xkb"
BDEPEND="virtual/pkgconfig
	${PYTHON_DEPS}
	
"
RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	>=x11-base/xcb-proto-${PV}
	
	
"
pkg_setup() {
	python-any-r1_pkg_setup
}

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
	  $(use_enable xkb)
--enable-xinput
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
