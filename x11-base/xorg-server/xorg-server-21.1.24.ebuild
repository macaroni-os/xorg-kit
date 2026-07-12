# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="x.org X server"
HOMEPAGE="https://www.x.org/wiki"
SRC_URI="https://xorg.freedesktop.org/archive/individual/xserver/xorg-server-21.1.24.tar.xz -> xorg-server-21.1.24.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="kdrive xephyr xnest xorg xvfb debug +elogind minimal selinux +suid +udev unwind xcsecurity systemd"
# Commons depends
CDEPEND="dev-libs/libbsd
	dev-libs/openssl
	media-libs/libglvnd[X]
	sys-devel/flex
	x11-apps/xkbcomp
	x11-base/xorg-proto
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXfont2
	x11-libs/libdrm
	x11-libs/libpciaccess
	x11-libs/libxkbfile
	x11-libs/libxshmfence
	x11-libs/pixman
	x11-libs/xtrans
	x11-misc/xkeyboard-config
	elogind? (
	  sys-apps/dbus
	  sys-auth/elogind[pam]
	)
	kdrive? (
	  x11-libs/libXext
	  x11-libs/libXv
	)
	udev? ( virtual/libudev )
	unwind? ( sys-libs/libunwind )
	xephyr? (
	  x11-libs/libxcb
	  x11-libs/xcb-util
	  x11-libs/xcb-util-image
	  x11-libs/xcb-util-keysyms
	  x11-libs/xcb-util-renderutil
	  x11-libs/xcb-util-wm
	)
	xnest? (
	  x11-libs/libXext
	  x11-libs/libX11
	)
	xorg? (
	  x11-apps/xinit
	  x11-libs/libxcvt
	)
	!minimal? (
	  x11-libs/libXext
	  x11-libs/libX11
	  media-libs/mesa[X(+),egl(+),gbm(+)]
	  media-libs/libepoxy[X,egl(+)]
	)
	systemd? (
	  sys-apps/dbus
	  sys-apps/systemd
	)
	
"
BDEPEND="media-fonts/font-util
	
"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-xserver )
	
"
DEPEND="${CDEPEND}
	
"
src_configure() {
	local emesonargs=(
	  --localstatedir "${EPREFIX}"/var
	  --sysconfdir "${EPREFIX}"/etc/X11
	  --buildtype $(usex debug debug plain)
	  -Db_ndebug=$(usex debug false true)
	  $(meson_use !minimal dri1)
	  $(meson_use !minimal dri2)
	  $(meson_use !minimal dri3)
	  $(meson_use !minimal glamor)
	  $(meson_use !minimal glx)
	  $(meson_use udev)
	  $(meson_use udev udev_kms)
	  $(meson_use unwind libunwind)
	  $(meson_use xcsecurity)
	  $(meson_use selinux xselinux)
	  $(meson_use xephyr)
	  $(meson_use xnest)
	  $(meson_use xorg)
	  $(meson_use xvfb)
	  -Ddocs=false
	  -Ddrm=true
	  -Ddtrace=false
	  -Dipv6=true
	  -Dhal=false
	  -Dlinux_acpi=false
	  -Dlinux_apm=false
	  -Dsecure-rpc=false
	  -Dsha1=libcrypto
	  -Dxkb_output_dir="${EPREFIX}"/var/lib/xkb
	  -Dxkb_dir="${EPREFIX}"/usr/share/X11/xkb
	  -Dsystemd_logind=true
	  $(meson_use suid suid_wrapper)
	  )
	 meson_src_configure
}

src_install() {
	meson_src_install
	 newinitd "${FILESDIR}"/xdm-setup.initd-1 xdm-setup
	newinitd "${FILESDIR}"/xdm.initd-14 xdm
	newconfd "${FILESDIR}"/xdm.confd-4 xdm
	 # The meson build system does not support install-setuid
	if ! use elogind; then
	  if use suid; then
	    chmod u+s "${ED}"/usr/bin/Xorg
	  fi
	fi
	 if ! use xorg; then
	  rm -f "${ED}"/usr/share/man/man1/Xserver.1x \
	    "${ED}"/usr/$(get_libdir)/xserver/SecurityPolicy \
	    "${ED}"/usr/$(get_libdir)/pkgconfig/xorg-server.pc \
	    "${ED}"/usr/share/man/man1/Xserver.1x || die
	fi
	 # install the @x11-module-rebuild set for Portage
	insinto /usr/share/portage/config/sets
	newins "${FILESDIR}"/xorg-sets.conf xorg.conf
}

pkg_postrm() {
	# Get rid of module dir to ensure opengl-update works properly
	if [[ -z ${REPLACED_BY_VERSION} && -e ${EROOT}/usr/$(get_libdir)/xorg/modules ]]; then
	  rm -rf "${EROOT}"/usr/$(get_libdir)/xorg/modules
	fi
}


# vim: filetype=ebuild
