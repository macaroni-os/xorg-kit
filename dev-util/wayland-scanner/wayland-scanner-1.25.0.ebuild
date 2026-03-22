# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="wayland-scanner tool"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland/-/archive/1.25.0/wayland-scanner-1.25.0.tar.bz2 -> wayland-scanner-1.25.0.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/expat:=
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/wayland-1.25.0"
post_src_unpack() {
	mv wayland-* ${S}
}
src_configure() {
	local emesonargs=(
	  -Ddocumentation=false
	  -Ddtd_validation=false
	  -Dlibraries=false
	  -Dscanner=true
	  -Dtests=false
	)
	meson_src_configure
}


# vim: filetype=ebuild
