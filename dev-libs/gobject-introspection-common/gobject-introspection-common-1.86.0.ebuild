# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )

DESCRIPTION="Build infrastructure for GObject Introspection"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"
SRC_URI="https://download.gnome.org/sources/gobject-introspection/1.86/gobject-introspection-1.86.0.tar.xz -> gobject-introspection-1.86.0.tar.xz"
LICENSE="HPND"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/gobject-introspection-1.86.0"
src_configure() { :; }
src_compile() { :; }
src_install() {
	dodir /usr/share/aclocal
	insinto /usr/share/aclocal
	doins m4/introspection.m4
	dodir /usr/share/gobject-introspection-1.0
	insinto /usr/share/gobject-introspection-1.0
	doins Makefile.introspection
}


# vim: filetype=ebuild
