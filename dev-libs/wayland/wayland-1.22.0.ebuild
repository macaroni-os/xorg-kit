# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland"
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland/-/archive/1.22.0/wayland-1.22.0.tar.bz2 -> wayland-1.22.0.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="doc"

BDEPEND="
	~dev-util/wayland-scanner-${PV}
	virtual/pkgconfig
	doc? (
		>=app-doc/doxygen-1.6[dot]
		app-text/xmlto
		>=media-gfx/graphviz-2.26.0
	)
"
DEPEND="
	>=dev-libs/expat-2.1.0-r3:=
	dev-libs/libxml2:=
	>=dev-libs/libffi-3.0.13-r1:=
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use doc documentation)
		-Ddtd_validation=true
		-Dlibraries=true
		-Dscanner=false
	)
	meson_src_configure
}