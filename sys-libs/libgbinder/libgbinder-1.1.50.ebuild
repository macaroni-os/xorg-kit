# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="GLib-style interface to binder"
HOMEPAGE="https://github.com/mer-hybris/libgbinder"
SRC_URI="https://api.github.com/repos/mer-hybris/libgbinder/tarball/refs/tags/1.1.50 -> libgbinder-1.1.50-2b2e22a.tar.gz"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="*"
RDEPEND="sys-libs/libglibutil
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv mer-hybris-libgbinder-* ${S}
}


src_compile() {
	emake LIBDIR=/usr/$(get_libdir)
}
src_install() {
	# Using install-dev instead of install
	# to install includes files.
	emake install-dev \
	  LIBDIR=/usr/$(get_libdir) \
	  DESTDIR="${D}"
	 dodir /usr/share/pkgconfig
	insinto /usr/share/pkgconfig
	newins "${S}"/build/${PN}.pc "${PN}.pc"
}



# vim: filetype=ebuild
