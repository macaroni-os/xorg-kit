# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg-utils

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://gitlab.freedesktop.org/xdg/shared-mime-info"
SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.5.1/shared-mime-info-2.5.1.tar.bz2 -> shared-mime-info-2.5.1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/glib
	dev-libs/libxml2
	
"
DEPEND="${RDEPEND}
	app-text/xmlto
	dev-util/intltool
	sys-devel/gettext
	app-text/docbook-xml-dtd:4.1.2
	virtual/pkgconfig
	
"
src_configure() {
	local emesonargs=(
	  -Dbuild-tools=true
	  -Dupdate-mimedb=false
	)
	meson_src_configure
}
pkg_postinst() {
	xdg_mimeinfo_database_update
}


# vim: filetype=ebuild
