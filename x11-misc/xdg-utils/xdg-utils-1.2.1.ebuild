# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-utils/"
SRC_URI="https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v1.2.1/xdg-utils-1.2.1.tar.bz2 -> xdg-utils-1.2.1.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/xdg-utils-1.2.1-qtpaths.patch"
	"${FILESDIR}/xdg-utils-1.2.1-xdg-mime-default.patch"
)
IUSE="dbus gnome doc"
REQUIRED_USE="gnome? ( dbus )"
BDEPEND="app-text/xmlto[text(+)]
	virtual/awk
	
"
RDEPEND="dev-util/desktop-file-utils
	dev-perl/File-MimeInfo
	dbus? (
	  sys-apps/dbus
	  gnome? (
	    dev-perl/Net-DBus
	    dev-perl/X11-Protocol
	  )
	)
	x11-misc/shared-mime-info
	x11-apps/xprop
	x11-apps/xset
	
"
post_src_unpack() {
	mv xdg-utils-* ${S}
}
src_configure() {
	export ac_cv_path_XMLTO="$(type -P xmlto) --skip-validation" #502166
	default
	emake -C scripts scripts-clean
}
src_install() {
	default
	dodoc RELEASE_NOTES
	newdoc scripts/xsl/README README.xsl
	use doc && dodoc -r scripts/html
	# Install default XDG_DATA_DIRS, bug #264647
	echo XDG_DATA_DIRS=\"${EPREFIX}/usr/local/share\" > 30xdg-data-local || die
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local || die
	doenvd 30xdg-data-local
	echo XDG_DATA_DIRS=\"${EPREFIX}/usr/share\" > 90xdg-data-base || die
	echo XDG_CONFIG_DIRS=\"${EPREFIX}/etc/xdg\" >> 90xdg-data-base || die
	doenvd 90xdg-data-base
}
pkg_postinst() {
	[[ -x $(type -P gtk-update-icon-cache) ]] \
	  || elog "Install dev-util/gtk-update-icon-cache for the gtk-update-icon-cache command."
}


# vim: filetype=ebuild
