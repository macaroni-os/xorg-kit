# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Compatibility X server to run under Wayland"
HOMEPAGE="https://wayland.freedesktop.org/xserver.html"
SRC_URI="https://xorg.freedesktop.org/archive/individual/xserver/xwayland-24.1.13.tar.xz -> xwayland-24.1.13.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="rpc libei unwind video_cards_nvidia xcsecurity libdecor"
# Commons depends
CDEPEND="dev-libs/libbsd
	dev-libs/openssl
	>=dev-libs/wayland-1.21.0
	>=dev-libs/wayland-protocols-1.30
	media-fonts/font-util
	media-libs/libepoxy[X,egl(+)]
	media-libs/libglvnd[X]
	media-libs/mesa[X(+),egl(+),gbm(+)]
	x11-apps/xkbcomp
	x11-base/xorg-proto
	x11-libs/libdrm
	x11-libs/libXau
	x11-libs/libxcvt
	x11-libs/libXdmcp
	x11-libs/libXfont2
	x11-libs/libxkbfile
	x11-libs/libxshmfence
	x11-libs/pixman
	x11-libs/xtrans
	x11-misc/xkeyboard-config
	libei? ( dev-libs/libei )
	libdecor? ( gui-libs/libdecor )
	unwind? ( sys-libs/libunwind )
	video_cards_nvidia? ( gui-libs/egl-wayland )
	
"
RDEPEND="${CDEPEND}
	!<=x11-base/xorg-server-1.20.11
	
"
DEPEND="${CDEPEND}
	
"
src_configure() {
	local emesonargs=(
	  $(meson_use rpc secure-rpc)
	  $(meson_use unwind libunwind)
	  $(meson_use xcsecurity)
	  $(meson_use libdecor)
	  -Dxselinux=false
	  -Ddpms=true
	  -Ddri3=true
	  -Ddtrace=false
	  -Dglamor=true
	  -Dglx=true
	  -Dipv6=true
	  -Dscreensaver=true
	  -Dsha1=libcrypto
	  -Dxace=true
	  -Dxdmcp=true
	  -Dxinerama=true
	  -Dxvfb=true
	  -Dxv=true
	  -Ddrm=true
	  -Dxwayland-path="${EPREFIX}"/usr/bin
	  -Dxwayland_ei=$(usex libei portal false)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	# Part of xorg-server
	rm -f "${ED}"/usr/share/man/man1/Xserver.1 || die
	# Part of xorg-server
	rm -f "${ED}"/usr/lib64/xorg/protocol.txt || die
}


# vim: filetype=ebuild
