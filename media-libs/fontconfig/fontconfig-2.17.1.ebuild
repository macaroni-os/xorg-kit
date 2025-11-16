# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="https://fontconfig.org/"
SRC_URI="https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/2.17.1/fontconfig-2.17.1.tar.xz -> fontconfig-2.17.1.tar.xz"
LICENSE="MIT"
SLOT="1.0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/fontconfig-2.14.0-latin-update.patch"
)
IUSE="doc static-libs nls"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/expat
	media-libs/freetype
	virtual/libintl
	
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	doc? (
	  =app-text/docbook-sgml-dtd-3.1*
	  app-text/docbook-sgml-utils[jadetex]
	)
	
"
src_configure() {
	local emesonargs=(
	  $(meson_feature doc)
	  $(meson_feature doc doc-html)
	  $(meson_feature doc doc-man)
	  $(meson_feature nls)
	  -Dtests=disabled
	  -Dcache-build=disabled
	  --localstatedir=/var
	  -Ddefault-fonts-dirs=/usr/share/fonts
	  -Dadditional-fonts-dirs="/usr/local/share/fonts,/usr/share/fonts"
	  -Dtemplate-dir=/etc/fonts/conf.avail
	  -Dfontations=disabled
	  -Dxml-backend=expat
	  -Ddefault-sub-pixel-rendering=none
	)
	 meson_src_configure
}
src_install() {
	meson_src_install
	 einstalldocs
	find "${ED}" -name "*.la" -delete || die
	 # fc-lang directory contains language coverage datafiles
	# which are needed to test the coverage of fonts.
	insinto /usr/share/fc-lang
	doins fc-lang/*.orth
	 dodoc doc/fontconfig-user.{txt,pdf}
	 if [[ -e ${ED}usr/share/doc/fontconfig/ ]];  then
	  mv "${ED}"usr/share/doc/fontconfig/* "${ED}"/usr/share/doc/${P} || die
	  rm -rf "${ED}"usr/share/doc/fontconfig
	fi
	 # Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf we force update it ...
	echo 'CONFIG_PROTECT_MASK="/etc/fonts/fonts.conf"' > "${T}"/37fontconfig
	doenvd "${T}"/37fontconfig
	 # As of fontconfig 2.7, everything sticks their noses in here.
	dodir /etc/sandbox.d
	echo 'SANDBOX_PREDICT="/var/cache/fontconfig"' > "${ED}"/etc/sandbox.d/37fontconfig
}
# TODO: preinst and postinst to move through whip.
pkg_preinst() {
	ebegin "Syncing fontconfig configuration to system"
	if [[ -e ${EROOT}/etc/fonts/conf.d ]]; then
	  for file in "${EROOT}"/etc/fonts/conf.avail/*; do
	    f=${file##*/}
	    if [[ -L ${EROOT}/etc/fonts/conf.d/${f} ]]; then
	      [[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
	        && ln -sf ../conf.avail/"${f}" "${ED}"etc/fonts/conf.d/ &>/dev/null
	    else
	      [[ -f ${ED}etc/fonts/conf.avail/${f} ]] \
	        && rm "${ED}"etc/fonts/conf.d/"${f}" &>/dev/null
	    fi
	  done
	fi
	eend $?
}
pkg_postinst() {
	einfo "Cleaning broken symlinks in ${EROOT%/}/etc/fonts/conf.d/"
	find -L "${EROOT}"etc/fonts/conf.d/ -type l -delete
	ebegin "Creating global font cache for ${ABI}"
	"${EPREFIX}"/usr/bin/fc-cache -srf
	eend $?
}


# vim: filetype=ebuild
