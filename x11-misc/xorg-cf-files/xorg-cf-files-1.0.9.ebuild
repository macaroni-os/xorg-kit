# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="Old Imake-related build files"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/xorg-cf-files"
SRC_URI="https://www.x.org/releases/individual/util/xorg-cf-files-1.0.9.tar.xz -> xorg-cf-files-1.0.9.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	
"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	
"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	 echo "#define ManDirectoryRoot ${EPREFIX}/usr/share/man" >> \
	  "${ED}"/usr/$(get_libdir)/X11/config/host.def || die
	sed -i -e "s|LibDirName *lib$|LibDirName $(get_libdir)|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/Imake.tmpl || die "failed libdir sed"
	sed -i -e "s|LibDir Concat(ProjectRoot,/lib/X11)|LibDir Concat(ProjectRoot,/$(get_libdir)/X11)|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/X11.tmpl || die "failed libdir sed"
	sed -i -e "s|\(EtcX11Directory \)\(/etc/X11$\)|\1${EPREFIX}\2|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/X11.tmpl || die "failed etcx11dir sed"
	sed -i -e "/#  define Solaris64bitSubdir/d" \
	  "${ED}"/usr/$(get_libdir)/X11/config/sun.cf || die
	sed -i -e 's/-DNOSTDHDRS//g' \
	  "${ED}"/usr/$(get_libdir)/X11/config/sun.cf || die
	 sed -r -i -e "s|LibDirName[[:space:]]+lib.*$|LibDirName $(get_libdir)|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/linux.cf || die "failed libdir sed"
	sed -r -i -e "s|SystemUsrLibDir[[:space:]]+/usr/lib.*$|SystemUsrLibDir /usr/$(get_libdir)|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/linux.cf || die "failed libdir sed"
	sed -r -i -e "s|TkLibDir[[:space:]]+/usr/lib.*$|TkLibDir /usr/$(get_libdir)|" \
	  "${ED}"/usr/$(get_libdir)/X11/config/linux.cf || die "failed libdir sed"
}


# vim: filetype=ebuild
