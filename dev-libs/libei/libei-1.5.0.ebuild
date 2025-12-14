# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="Library for Emulated Input, primarily aimed at the Wayland stack"
HOMEPAGE="https://gitlab.freedesktop.org/libinput/libei"
SRC_URI="
https://gitlab.freedesktop.org/libinput/libei/-/archive/1.5.0/libei-1.5.0.tar.bz2 -> libei-1.5.0.tar.bz2
https://github.com/nemequ/munit/archive/fbbdf1467eb0d04a6ee465def2e529e4c87f2118.tar.gz -> libei-1.5.0-munin-fbbdf14.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="+elogind systemd"
BDEPEND="virtual/pkgconfig
	$(python_gen_any_dep '
	  dev-python/jinja[${PYTHON_USEDEP}]
	')
	
"
RDEPEND="dev-libs/libevdev
	systemd? ( sys-apps/systemd )
	elogind? ( sys-auth/elogind )
	
"
DEPEND="${RDEPEND}
"
src_unpack() {
	if [[ -n ${A} ]]; then
	  unpack ${A}
	  mv "${WORKDIR}"/munit-* "${WORKDIR}"/${P}/subprojects/munit || die
	  rm "${WORKDIR}"/${P}/subprojects/munit.wrap || die
	fi
}
src_prepare() {
	default
	sed -i -e 's:^valgrind = .*:valgrind = disabler():g' test/meson.build || die
}
src_configure() {
	local emesonargs=(
	  -Ddocumentation=""
	  -Dliboeffis=enabled
	  -Dtests=disabled
	)
	if use systemd; then
	  emesonargs+=(-Dsd-bus-provider=libsystemd)
	elif use elogind; then
	  emesonargs+=(-Dsd-bus-provider=libelogind)
	#else
	#  emesonargs+=(-Dsd-bus-provider=basu)
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
