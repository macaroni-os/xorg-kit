# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg gnome3

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gdk-pixbuf"
SRC_URI="https://download.gnome.org/sources/gdk-pixbuf/2.44/gdk-pixbuf-2.44.4.tar.xz -> gdk-pixbuf-2.44.4.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="gtk-doc +introspection gif jpeg tiff glycin"
BDEPEND="gtk-doc? ( dev-util/gi-docgen )
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.3
	dev-libs/libxslt
	dev-python/docutils
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	x11-misc/shared-mime-info
	media-libs/libpng:=
	jpeg? ( media-libs/libjpeg-turbo:= )
	tiff? ( media-libs/tiff:= )
	glycin? ( media-libs/libglycin:= )
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	
"
src_configure() {
	local emesonargs=(
	  -Dpng=enabled
	  -Dtests=false
	  $(meson_feature gif)
	  -Dothers=enabled
	  $(meson_feature tiff)
	  $(meson_feature glycin)
	  $(meson_feature jpeg)
	  -Dbuiltin_loaders=png,jpeg
	  -Drelocatable=false
	  -Dinstalled_tests=false
	  -Dgio_sniffing=true
	  -Ddocumentation=$(usex gtk-doc true false)
	  -Dman=true
	  $(meson_feature introspection)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}
pkg_preinst() {
	xdg_pkg_preinst
	# Make sure loaders.cache belongs to gdk-pixbuf alone
	local cache="usr/$(get_libdir)/${PN}-2.0/2.10.0/loaders.cache"
	if [[ -e ${EROOT}/${cache} ]]; then
	  cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
	  touch "${ED}"/${cache} || die
	fi
}
pkg_postinst() {
	xdg_pkg_postinst
	gnome3_pkg_postinst
}
pkg_postrm() {
	xdg_pkg_postrm
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
	  rm -f "${EROOT}"/usr/lib*/${PN}-2.0/2.10.0/loaders.cache
	fi
}


# vim: filetype=ebuild
