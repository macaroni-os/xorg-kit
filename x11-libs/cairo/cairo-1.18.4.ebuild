# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="https://www.cairographics.org/ https://gitlab.freedesktop.org/cairo/cairo"
SRC_URI="https://cairographics.org/releases/cairo-1.18.4.tar.xz -> cairo-1.18.4.tar.xz"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/cairo-respect-fontconfig.patch"
)
IUSE="X aqua debug +glib gtk-doc lzo"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	
"
RDEPEND="media-libs/fontconfig
	media-libs/freetype:2[png]
	media-libs/libpng:0=
	sys-libs/zlib
	x11-libs/pixman
	debug? ( sys-libs/binutils-libs:0= )
	glib? ( dev-libs/glib:2 )
	lzo? ( dev-libs/lzo:2 )
	X? (
	  x11-libs/libXrender
	  x11-libs/libXext
	  x11-libs/libX11
	  x11-libs/libxcb
	)
	
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
	
"
src_configure() {
	local emesonargs=(
	  -Ddwrite=disabled
	  -Dfontconfig=enabled
	  -Dfreetype=enabled
	  -Dpng=enabled
	  $(meson_feature aqua quartz)
	  $(meson_feature X tee)
	  $(meson_feature X xcb)
	  $(meson_feature X xlib)
	  $(meson_feature lzo)
	  -Dxlib-xcb=disabled
	  -Dzlib=enabled
	  -Dtests=disabled
	  -Dgtk2-utils=disabled
	  $(meson_feature glib)
	  -Dspectre=disabled # only used for tests
	  $(meson_feature debug symbol-lookup)
	  $(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	einstalldocs
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/cairo || die
	  mv "${ED}"/usr/share/gtk-doc/{html/cairo,cairo/html} || die
	  rmdir "${ED}"/usr/share/gtk-doc/html || die
	fi
}


# vim: filetype=ebuild
