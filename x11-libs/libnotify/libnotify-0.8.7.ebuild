# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg-utils

DESCRIPTION=""
SRC_URI="https://download.gnome.org/sources/libnotify/0.8/libnotify-0.8.7.tar.xz -> libnotify-0.8.7.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="app-eselect/eselect-notify-send
	dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	dev-util/gtk-doc-am
	app-text/docbook-xsl-ns-stylesheets
	
"
PDEPEND="virtual/notification-daemon
	
"
src_prepare() {
	default
	xdg_environment_reset
}
src_configure() {
	local emesonargs=( \
	  -Dgtk_doc=false \
	  -Ddocbook_docs=disabled \
	  $(meson_feature introspection)
	  -Dtests=false
	)
	meson_src_configure
	# work-around gtk-doc out-of-source brokedness
	ln -s "${S}"/docs/reference/html docs/reference/html || die
}
src_install() {
	meson_src_install
	mv "${ED}"/usr/bin/{,libnotify-}notify-send || die #379941
}
pkg_postinst() {
	eselect notify-send update ifunset
}
pkg_postrm() {
	eselect notify-send update ifunset
}


# vim: filetype=ebuild
