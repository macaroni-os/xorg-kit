# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Tool to help manage 'well known' user directories"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-user-dirs"
SRC_URI="https://user-dirs.freedesktop.org/releases/xdg-user-dirs-0.19.tar.xz -> xdg-user-dirs-0.19.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog
	NEWS
)
IUSE="gtk"
BDEPEND="app-text/docbook-xml-dtd:4.3
	sys-devel/gettext
	
"
PDEPEND="gtk? ( x11-misc/xdg-user-dirs-gtk )
	
"

# vim: filetype=ebuild
