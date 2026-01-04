# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Command line utilities to work with desktop menu entries"
HOMEPAGE="https://freedesktop.org/wiki/Software/desktop-file-utils/"
SRC_URI="https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.28.tar.xz -> desktop-file-utils-0.28.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog
	HACKING
	NEWS
	README
)
BDEPEND="app-arch/xz-utils
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	
"
DEPEND="${RDEPEND}
	
"

# vim: filetype=ebuild
