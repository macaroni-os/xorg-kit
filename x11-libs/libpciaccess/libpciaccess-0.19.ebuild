# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="Library providing generic access to the PCI bus and devices"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/libpciaccess"
SRC_URI="https://www.x.org/releases/individual/lib/libpciaccess-0.19.tar.xz -> libpciaccess-0.19.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="zlib"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	sys-apps/hwdata
	
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	media-fonts/font-util
	x11-base/xorg-proto
	zlib? ( sys-libs/zlib:= )
	
	
"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  -Dpci-ids="${EPREFIX}"/usr/share/hwdata
$(meson_feature zlib)
	 )
	meson_src_configure
}


# vim: filetype=ebuild
