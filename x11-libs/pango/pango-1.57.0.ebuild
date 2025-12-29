# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic meson toolchain-funcs xdg

DESCRIPTION="Internationalized text layout and rendering library"
HOMEPAGE="https://www.pango.org/ https://gitlab.gnome.org/GNOME/pango"
SRC_URI="https://download.gnome.org/sources/pango/1.57/pango-1.57.0.tar.xz -> pango-1.57.0.tar.xz"
LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="debug doc +introspection sysprof X"
BDEPEND="
	sys-apps/help2man
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/fribidi
	media-libs/harfbuzz:=[glib(+),introspection?,truetype(+)]
	>=media-libs/fontconfig-2.17.1:1.0=
	x11-libs/cairo:=[X?]
	media-libs/freetype:2=
	introspection? ( >=dev-libs/gobject-introspection-1.83.2:= )
	X? (
	  x11-libs/libX11
	  x11-libs/libXft
	  x11-libs/libXrender
	)
	
"
DEPEND="${RDEPEND}
	sysprof? ( dev-util/sysprof-capture )
	X? ( x11-base/xorg-proto )
	
"
src_prepare() {
	xdg_src_prepare
	export G_HOME="${T}"
	export GST_REGISTRY="${T}/registry.xml"
	export GSETTINGS_BACKEND="memory"
	export GST_INSPECT="$(type -P true)"
	unset DISPLAY
}
src_configure() {
	if use debug; then
	  append-cflags -DPANGO_ENABLE_DEBUG
	else
	  append-cflags -DG_DISABLE_CAST_CHECKS
	fi
	local emesonargs=(
	  --wrap-mode nofallback
	  -Ddocumentation=false
	  -Dbuild-testsuite=false
	  -Dlibthai=disabled
	  -Dcairo=enabled
	  -Dfontconfig=enabled
	  -Dfreetype=enabled
	  $(meson_feature introspection)
	  $(meson_feature sysprof)
	  $(meson_feature X xft)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use doc; then
	  insinto /usr/share/gtk-doc/html
	  doins -r "${S}"/docs/Pango*
	fi
}
pkg_postinst() {
	xdg_pkg_postinst
	if has_version 'media-libs/freetype[-harfbuzz]' ; then
	  ewarn "media-libs/freetype is installed without harfbuzz support. This may"
	  ewarn "lead to minor font rendering problems, see bug 712374."
	fi
}


# vim: filetype=ebuild
