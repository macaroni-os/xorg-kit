# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION=""
SRC_URI="https://download.gnome.org/sources/glib/2.86/glib-2.86.2.tar.xz -> glib-2.86.2.tar.xz"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gdbus-codegen-2.60.3-sitedir.patch"
)
BDEPEND="dev-python/docutils
	
"
RDEPEND="${PYTHON_DEPS}
	
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	
"
PDEPEND=">=dev-libs/glib-2.86.2
	
"
S="${WORKDIR}/glib-2.86.2/gio/gdbus-2.0/codegen"
src_prepare() {
	distutils-r1_src_prepare
	sed -e 's:@PYTHON@:python:' gdbus-codegen.in > gdbus-codegen || die
	sed -e "s:@VERSION@:${PV}:" \
	  -e "s:@MAJOR_VERSION@:$(ver_cut 1):" \
	  -e "s:@MINOR_VERSION@:$(ver_cut 2):" config.py.in > config.py || die
	cp "${FILESDIR}/setup.py-2.32.4" setup.py || die "cp failed"
	sed -e "s/@PV@/${PV}/" -i setup.py || die "sed setup.py failed"
}
do_xsltproc_command() {
	# Taken from meson.build for manual manpage building - keep in sync (also copied to dev-util/glib-utils)
	xsltproc \
	  --nonet \
	  --stringparam man.output.quietly 1 \
	  --stringparam funcsynopsis.style ansi \
	  --stringparam man.th.extra1.suppress 1 \
	  --stringparam man.authors.section.enabled 0 \
	  --stringparam man.copyright.section.enabled 0 \
	  -o "${2}" \
	  http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl \
	  "${1}" || die "manpage generation failed"
}
src_compile() {
	distutils-r1_src_compile
	rst2man \
	  "${WORKDIR}/glib-${PV}/docs/reference/gio/gdbus-codegen.rst" \
	  "${WORKDIR}/glib-${PV}/docs/reference/gio/gdbus-codegen.1"
}
src_install() {
	distutils-r1_src_install
	doman "${WORKDIR}/glib-${PV}/docs/reference/gio/gdbus-codegen.1"
}


# vim: filetype=ebuild
