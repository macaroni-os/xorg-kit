# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland/-/archive/1.26.0/wayland-1.26.0.tar.bz2 -> wayland-1.26.0.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND=">=dev-util/wayland-scanner-1.26.0
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/expat:=
	dev-libs/libxml2:=
	dev-libs/libffi:=
	
"
DEPEND="${RDEPEND}
"
post_src_unpack() {
	mv wayland-* ${S}
}
src_configure() {
	local emesonargs=(
	  -Ddocumentation=false
	  -Ddtd_validation=true
	  -Dlibraries=true
	  -Dscanner=false
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
