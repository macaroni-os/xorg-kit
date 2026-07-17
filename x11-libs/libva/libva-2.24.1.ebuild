# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Libva is an implementation for VA-API (Video Acceleration API)"
HOMEPAGE="http://intel.github.io/libva/"
SRC_URI="https://github.com/intel/libva/releases/download/2.24.1/libva-2.24.1.tar.bz2 -> libva-2.24.1-710eb46.tar.bz2"
LICENSE="MIT"
SLOT="0/2"
KEYWORDS="*"
DOCS=(
	NEWS
)
IUSE="+drm opengl vdpau wayland X
video_cards_nvidia
video_cards_intel
video_cards_i965
video_cards_nouveau
"
REQUIRED_USE="|| ( drm wayland X )
opengl? ( X )
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-libs/libdrm
	opengl? ( virtual/opengl )
	wayland? ( dev-libs/wayland )
	X? (
	  x11-libs/libX11
	  x11-libs/libXext
	  x11-libs/libXfixes
	)
	
"
DEPEND="${RDEPEND}
"
PDEPEND="video_cards_nvidia? ( x11-libs/libva-vdpau-driver )
	video_cards_nouveau? ( x11-libs/libva-vdpau-driver )
	vdpau? ( x11-libs/libva-vdpau-driver )
	video_cards_intel? ( x11-libs/libva-intel-driver )
	video_cards_i965? ( x11-libs/libva-intel-driver )
	
"
src_configure() {
	local emesonargs=(
	  -Ddriverdir=/usr/$(get_libdir)/va/drivers
	  -Ddisable_drm=$(usex drm false true)
	  -Dwith_x11=$(usex X yes no)
	  -Dwith_wayland=$(usex wayland yes no)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	find "${ED}" -type f -name "*.la" -delete || die
}


# vim: filetype=ebuild
