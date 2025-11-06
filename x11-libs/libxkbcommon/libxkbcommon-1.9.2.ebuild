# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="keymap handling library for toolkits and window systems"
HOMEPAGE="https://xkbcommon.org"
SRC_URI="https://api.github.com/repos/xkbcommon/libxkbcommon/tarball/refs/tags/xkbcommon-1.9.2 -> libxkbcommon-1.9.2-dd64235.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs tools wayland X"
BDEPEND="sys-devel/bison
	wayland? ( dev-util/wayland-scanner )
	
"
RDEPEND="X? ( x11-libs/libxcb[xkb] )
	wayland? ( dev-libs/wayland )
	dev-libs/libxml2
	x11-misc/compose-tables
	
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
	wayland? ( dev-libs/wayland-protocols )
	
"

post_src_unpack() {
	mv xkbcommon-libxkbcommon-* ${S}
}


src_configure() {
	local emesonargs=(
	  -Ddefault_library="$(usex static-libs both shared)"
	  -Dxkb-config-root="${EPREFIX}/usr/share/X11/xkb"
	  -Denable-docs=false
	  $(meson_use tools enable-tools)
	  $(meson_use X enable-x11)
	  $(meson_use wayland enable-wayland)
	)
	meson_src_configure
}



# vim: filetype=ebuild
