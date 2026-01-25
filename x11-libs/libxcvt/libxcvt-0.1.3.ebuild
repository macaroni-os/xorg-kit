# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="X.Org xcvt library and cvt program"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libxcvt"
SRC_URI="https://www.x.org/releases/individual/lib/libxcvt-0.1.3.tar.xz -> libxcvt-0.1.3.tar.xz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
DEPEND="sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	
"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  
	)
	meson_src_configure
}


# vim: filetype=ebuild
