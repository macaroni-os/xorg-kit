# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic meson python-any-r1 xdg-utils

DESCRIPTION="HarfBuzz text shaping engine"
HOMEPAGE="http://harfbuzz.github.io/"
SRC_URI="https://api.github.com/repos/harfbuzz/harfbuzz/tarball/12.3.0 -> harfbuzz-12.3.0-b0af592.tar.gz"
LICENSE="Old-MIT ISC icu"
SLOT="0"
KEYWORDS="*"
IUSE="+cairo debug experimental +glib +graphite icu +introspection +truetype"
REQUIRED_USE="introspection?  ( glib )"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	
"
RDEPEND="cairo? ( x11-libs/cairo )
	glib? ( dev-libs/glib:2 )
	graphite? ( media-gfx/graphite2 )
	icu? ( dev-libs/icu )
	introspection? ( dev-libs/gobject-introspection:= )
	truetype? ( media-libs/freetype:2= )
	
"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	
"

post_src_unpack() {
	mv harfbuzz-harfbuzz-* ${S}
}


pkg_setup() {
	python-any-r1_pkg_setup
	if ! use debug ; then
	  append-cppflags -DHB_NDEBUG
	fi
}
src_prepare() {
	default
	xdg_environment_reset
}
src_configure() {
	# harfbuzz-gobject only used for introspection, bug #535852
	local emesonargs=(
	  -Dcoretext="disabled"
	  -Dchafa="disabled"
	  -Ddocs="disabled"
	  -Dtests="disabled"
	  $(meson_feature glib)
	  $(meson_feature graphite graphite2)
	  $(meson_feature icu)
	  $(meson_feature introspection gobject)
	  $(meson_feature truetype freetype)
	  $(meson_feature cairo)
	  $(meson_feature introspection)
	  $(meson_use experimental experimental_api)
	)
	meson_src_configure
}



# vim: filetype=ebuild
