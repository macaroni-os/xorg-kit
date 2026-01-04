# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Multitouch Protocol Translation Library"
HOMEPAGE="http://bitmath.org/code/mtdev/"
SRC_URI="https://bitmath.se/org/code/mtdev/mtdev-1.1.7.tar.bz2 -> mtdev-1.1.7.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs"
BDEPEND="sys-kernel/linux-headers
	
"
src_configure() {
	econf $(use_enable static-libs static)
}
src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}


# vim: filetype=ebuild
