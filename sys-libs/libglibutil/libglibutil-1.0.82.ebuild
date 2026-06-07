# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="Library of glib utilities"
HOMEPAGE="https://github.com/sailfishos/libglibutil"
SRC_URI="https://api.github.com/repos/sailfishos/libglibutil/tarball/refs/tags/1.0.82 -> libglibutil-1.0.82-cccc4aa.tar.gz"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv sailfishos-libglibutil-* ${S}
}


src_compile() {
	emake LIBDIR=/usr/$(get_libdir)
}
src_install() {
	# Using install-dev instead of install to
	# install includes files too.
	emake install-dev LIBDIR=/usr/$(get_libdir) DESTDIR="${D}"
	dodir /usr/share/pkgconfig
	insinto /usr/share/pkgconfig
	newins "${S}"/build/${PN}.pc "${PN}.pc"
}



# vim: filetype=ebuild
