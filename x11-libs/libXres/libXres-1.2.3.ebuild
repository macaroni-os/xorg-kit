# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="X.Org Xres library"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libXres"
SRC_URI="https://www.x.org/releases/individual/lib/libXres-1.2.3.tar.xz -> libXres-1.2.3.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	
	
"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  
	)
	meson_src_configure
}


# vim: filetype=ebuild
