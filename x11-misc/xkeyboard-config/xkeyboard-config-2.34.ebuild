# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X keyboard configuration database"
SRC_URI="https://www.x.org/releases/individual/data/xkeyboard-config/xkeyboard-config-2.34.tar.bz2 -> xkeyboard-config-2.34.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	sys-devel/gettext
	dev-util/intltool
	
"

src_prepare() {
	
	eautoreconf || die
	default
}
src_configure() {
	local no_static=""
	local shared=""
	# Check if package supports disabling of static libraries
	if grep -q -s "able-static" ${ECONF_SOURCE:-.}/configure; then
	  no_static="--disable-static"
	fi
	if grep -q -s "enable-shared" ${ECONF_SOURCE:-.}/configure; then
	  shared="--enable-shared"
	fi
	local econfargs=(
	  ${shared}
	  ${no_static}
	  --with-xkb-base="${EPREFIX}/usr/share/X11/xkb"
--enable-compat-rules
# do not check for runtime deps
--disable-runtime-deps
--with-xkb-rules-symlink=xorg
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	
}


# vim: filetype=ebuild
