# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1 udev

DESCRIPTION="libwacom is a tablet description library"
HOMEPAGE="https://github.com/linuxwacom/libwacom"
SRC_URI="https://github.com/linuxwacom/libwacom/releases/download/libwacom-2.20.0/libwacom-2.20.0.tar.xz -> libwacom-2.20.0-d4efe93.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="doc"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	doc? (
	  app-doc/doxygen
	)
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/libevdev
	dev-libs/libgudev:=
	
"
DEPEND="${RDEPEND}
	
"
src_configure() {
	local emesonargs=(
		$(meson_feature doc documentation)
		-Dtests=disabled
		-Dudev-dir=$(get_udevdir)
	)
	meson_src_configure
}
pkg_postinst() {
	udev_reload
}
pkg_postrm() {
	udev_reload
}


# vim: filetype=ebuild
