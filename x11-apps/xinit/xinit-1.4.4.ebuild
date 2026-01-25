# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="X Window System initializer"
SRC_URI="https://www.x.org/releases/individual/app/xinit-1.4.4.tar.xz -> xinit-1.4.4.tar.xz"
LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/xinit-1.4.4-gentoo-customizations.patch"
	"${FILESDIR}/xinit-1.4.4-startx-current-vt.patch"
)
IUSE="+minimal"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="x11-apps/xauth
	x11-libs/libX11
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	x11-misc/util-macros
	x11-base/xorg-proto
	
	
"
PDEPEND="x11-apps/xrdb
	!minimal? (
	  x11-apps/xclock
	  x11-apps/xsm
	  x11-terms/xterm
	  x11-wm/twm
	)
	
"
pkg_postinst() {
	ewarn "If you use startx to start X instead of a login manager like gdm/kdm,"
	ewarn "you can set the XSESSION variable to anything in /etc/X11/Sessions/ or"
	ewarn "any executable. When you run startx, it will run this as the login session."
	ewarn "You can set this in a file in /etc/env.d/ for the entire system,"
	ewarn "or set it per-user in ~/.bash_profile (or similar for other shells)."
	ewarn "Here's an example of setting it for the whole system:"
	ewarn "    echo XSESSION=\"Gnome\" > /etc/env.d/90xsession"
	ewarn "    env-update && source /etc/profile"
}

src_prepare() {
	
	eautoreconf || die
	default
}
src_configure() {
	local no_static=""
	local shared=""
	# Check if package supports disabling of static libraries
	if grep -q -s "able-static" ${ECONF_SOURCE:-.}/configure; then
	  no_static="--disable-static"
	fi
	if grep -q -s "enable-shared" ${ECONF_SOURCE:-.}/configure; then
	  shared="--enable-shared"
	fi
	local econfargs=(
	  ${shared}
	  ${no_static}
	  --with-xinitdir="${EPREFIX}"/etc/X11/xinit
	 )
	econf "${econfargs[@]}"
}
src_install() {
	default
	find "${D}" -type f -name '*.la' -delete || die
	exeinto /etc/X11
doexe "${FILESDIR}"/chooser.sh "${FILESDIR}"/startDM.sh
exeinto /etc/X11/Sessions
doexe "${FILESDIR}"/Xsession
exeinto /etc/X11/xinit
newexe "${FILESDIR}"/xserverrc.1 xserverrc
exeinto /etc/X11/xinit/xinitrc.d/
doexe "${FILESDIR}"/00-xhost
insinto /usr/share/xsessions
doins "${FILESDIR}"/Xsession.desktop

}


# vim: filetype=ebuild
