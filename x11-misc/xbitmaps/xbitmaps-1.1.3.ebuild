# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X.Org bitmaps data"
SRC_URI="https://www.x.org/releases/individual/data/xbitmaps-1.1.3.tar.xz -> xbitmaps-1.1.3.tar.xz"
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
	
"
src_compile() { true; }


# vim: filetype=ebuild
