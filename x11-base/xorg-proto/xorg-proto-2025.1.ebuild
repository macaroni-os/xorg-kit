# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/proto/xorgproto"
SRC_URI="https://www.x.org/releases/individual/proto/xorgproto-2025.1.tar.xz -> xorgproto-2025.1.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/xorgproto-2025.1"
src_configure() {
	local emesonargs=(
	  --datadir=/usr/share
	  -Dlegacy=false
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	DOCS=(
	  AUTHORS
	  PM_spec
	  $(set +f; echo COPYING-*)
	  $(set +f; echo *.txt | grep -v meson.txt)
	)
	einstalldocs
}


# vim: filetype=ebuild
