# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson bash-completion-r1 flag-o-matic gnome3 libtool pax-utils python-any-r1 toolchain-funcs

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"
SRC_URI="https://download.gnome.org/sources/glib/2.86/glib-2.86.1.tar.xz -> glib-2.86.1.tar.xz"
SLOT="2"
KEYWORDS="*"
IUSE="dbus fam gtk-doc +mime selinux static-libs systemtap xattr"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libpcre[static-libs?]
	virtual/libicon
	virtual/libffi:=
	virtual/libintl
	sys-libs/zlib
	sys-apps/util-linux
	selinux? ( sys-libs/libselinux )
	fam? ( virtual/fam )
	>=dev-util/gdbus-codegen-2.86.1
	virtual/libelf:0=
	
"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-devel/gettext
	gtk-doc? ( dev-util/gtk-doc )
	systemtap? ( dev-util/systemtap )
	
"
PDEPEND="dbus? ( gnome-base/dconf )
	mime? ( x11-misc/shared-mime-info )
	
"
pkg_setup() {
	python-any-r1_pkg_setup
}
src_prepare() {
	default
	# Don't build tests, also prevents extra deps, bug #512022
	sed -i -e "/subdir('tests')/d" {.,gio,glib}/meson.build || die
	# gdbus-codegen is a separate package
	sed -i -e "s/install : true/install : false/" \
	  -i -e "s/install_dir : get_option('bindir')/install_dir : '' /" \
	  -i -e "s/install_dir : codegen_dir/install_dir : '' /" gio/gdbus-2.0/codegen/meson.build
	sed -i -e "s/[, ]*'gdbus-codegen.*'[,]*//" docs/reference/gio/meson.build
	# Tarball doesn't come with gtk-doc.make and we can't unconditionally depend on dev-util/gtk-doc due
	# to circular deps during bootstramp. If actually not building gtk-doc, an almost empty file will do
	# fine as well - this is also what upstream autogen.sh does if gtkdocize is not found. If gtk-doc is
	# installed, eautoreconf will call gtkdocize, which overwrites the empty gtk-doc.make with a full copy.
	echo 'EXTRA_DIST =' > gtk-doc.make
	echo 'CLEANFILES =' >> gtk-doc.make
}
src_configure() {
	# Avoid circular depend with dev-util/pkgconfig and
	# native builds (cross-compiles won't need pkg-config
	# in the target ROOT to work here)
	if ! $(tc-getPKG_CONFIG) --version >& /dev/null; then
	  if has_version sys-apps/dbus; then
	    export DBUS1_CFLAGS="-I/usr/include/dbus-1.0 -I/usr/$(get_libdir)/dbus-1.0/include"
	    export DBUS1_LIBS="-ldbus-1"
	  fi
	  export LIBFFI_CFLAGS="-I$(echo /usr/$(get_libdir)/libffi-*/include)"
	  export LIBFFI_LIBS="-lffi"
	  export PCRE_CFLAGS=" " # test -n "$PCRE_CFLAGS" needs to pass
	  export PCRE_LIBS="-lpcre"
	fi
	local emesonargs=(
	  -Dc_args="${CFLAGS}"
	  -Dman-pages=enabled
	  -Ddefault_library=$(usex static-libs both shared)
	  $(meson_use xattr)
	  $(meson_use gtk-doc documentation)
	  -Dlibmount=enabled
	  -Dselinux=$(usex selinux enabled disabled)
	  $(meson_feature systemtap dtrace)
	  $(meson_feature systemtap)
	)
	meson_src_configure
}
src_install() {
	meson_src_install completiondir="$(get_bashcompdir)"
	keepdir /usr/$(get_libdir)/gio/modules
	einstalldocs
	# Do not install charset.alias even if generated, leave it to libiconv
	rm -f "${ED}/usr/$(get_libdir)/charset.alias"
	# Don't install gdb python macros, bug 291328
	rm -rf "${ED}/usr/share/gdb/" "${ED}/usr/share/glib-2.0/gdb/"
	# Completely useless with or without USE static-libs, people need to use pkg-config
	find "${ED}" -name '*.la' -delete || die
}
pkg_preinst() {
	gnome3_pkg_preinst
	# Make gschemas.compiled belong to glib alone
	local cache="usr/share/glib-2.0/schemas/gschemas.compiled"
	if [[ -e ${EROOT}${cache} ]]; then
	  cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
	  touch "${ED}"/${cache} || die
	fi
	# Make giomodule.cache belong to glib alone
	local cache="usr/$(get_libdir)/gio/modules/giomodule.cache"
	if [[ -e ${EROOT}${cache} ]]; then
	  cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
	  touch "${ED}"/${cache} || die
	fi
}
pkg_postinst() {
	# force (re)generation of gschemas.compiled
	GNOME3_ECLASS_GLIB_SCHEMAS="force"
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
	  rm -f "${EROOT}"usr/$(get_libdir)/gio/modules/giomodule.cache
	  rm -f "${EROOT}"usr/share/glib-2.0/schemas/gschemas.compiled
	fi
}


# vim: filetype=ebuild
