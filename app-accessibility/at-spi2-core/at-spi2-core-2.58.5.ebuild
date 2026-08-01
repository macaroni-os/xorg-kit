# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson systemd

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://gitlab.gnome.org/GNOME/at-spi2-core"
SRC_URI="https://download.gnome.org/sources/at-spi2-core/2.58/at-spi2-core-2.58.5.tar.xz -> at-spi2-core-2.58.5.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="X dbus-broker gtk-doc +introspection systemd"
REQUIRED_USE="gtk-doc? ( X )
"
# Commons depends
CDEPEND="sys-apps/dbus
	dev-libs/glib:2
	dev-libs/libxml2:2
	introspection? ( dev-libs/gobject-introspection:= )
	systemd? ( sys-apps/systemd )
	X? (
	  x11-libs/libX11
	  x11-libs/libXtst
	  x11-libs/libXi
	)
	>=app-accessibility/at-spi2-atk-2.46.0
	!<dev-libs/atk-2.58.0
	
"
RDEPEND="${CDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	
"
DEPEND="${CDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Ddefault_bus=dbus-daemon
	  $(meson_use systemd use_systemd)
	  -Dgtk2_atk_adaptor=true
	  -Dsystemd_user_dir="$(systemd_get_userunitdir)"
	  -Ddocs=$(usex gtk-doc true false)
	  $(meson_feature introspection)
	  $(meson_feature X x11)
	  -Datk_only=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	einstalldocs
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/{libatspi,atk} || die
	  mv "${ED}"/usr/share/doc/libatspi "${ED}"/usr/share/gtk-doc/libatspi/html || die
	  mv "${ED}"/usr/share/doc/atk "${ED}"/usr/share/gtk-doc/atk/html || die
	fi
}


# vim: filetype=ebuild
