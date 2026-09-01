# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic libtool toolchain-funcs

DESCRIPTION=""
SRC_URI="
https://download.savannah.gnu.org/releases/freetype/freetype-2.14.3.tar.xz -> freetype-2.14.3.tar.xz
utils? ( https://download.savannah.gnu.org/releases/freetype/ft2demos-2.14.3.tar.xz -> freetype-2.14.3-ft2demos.tar.xz )"
LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"
KEYWORDS="*"
IUSE="X +adobe-cff brotli bzip2 +cleartype_hinting debug fontforge harfbuzz png static-libs utils"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="sys-libs/zlib
	brotli? ( app-arch/brotli )
	bzip2? ( app-arch/bzip2 )
	harfbuzz? ( media-libs/harfbuzz[truetype] )
	png? ( media-libs/libpng )
	utils? (
	  X? (
	    x11-libs/libX11
	    x11-libs/libXau
	    x11-libs/libXdmcp
	  )
	)
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	# This is the same as the 01 patch from infinality
	sed '/AUX_MODULES += \(gx\|ot\)valid/s@^# @@' -i modules.cfg || die
	enable_option() {
	  sed -i -e "/#define $1/ { s:/\* ::; s: \*/:: }" \
	    include/${PN}/config/ftoption.h \
	    || die "unable to enable option $1"
	}
	disable_option() {
	  sed -i -e "/#define $1/ { s:^:/* :; s:$: */: }" \
	    include/${PN}/config/ftoption.h \
	    || die "unable to disable option $1"
	}
	# Will be the new default for >=freetype-2.7.0
	disable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"
	if use cleartype_hinting; then
	  enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"
	fi
	# Can be disabled with FREETYPE_PROPERTIES="pcf:no-long-family-names=1"
	# via environment (new since v2.8)
	enable_option PCF_CONFIG_OPTION_LONG_FAMILY_NAMES
	# See http://freetype.org/patents.html
	# ClearType is covered by several Microsoft patents in the US
	enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING
	if ! use adobe-cff; then
	  enable_option CFF_CONFIG_OPTION_OLD_ENGINE
	fi
	if use debug; then
	  enable_option FT_DEBUG_LEVEL_TRACE
	  enable_option FT_DEBUG_MEMORY
	fi
	if use utils; then
	  cd "${WORKDIR}/ft2demos-${PV}" || die
	  # Disable tests needing X11 when USE="-X". (bug #177597)
	  if ! use X; then
	    sed -i -e "/EXES\ +=\ ftdiff/ s:^:#:" Makefile || die
	  fi
	  cd "${S}" || die
	fi
	# we need non-/bin/sh to run configure
	if [[ -n ${CONFIG_SHELL} ]] ; then
	  sed -i -e "1s:^#![[:space:]]*/bin/sh:#!${CONFIG_SHELL}:" \
	    "${S}"/builds/unix/configure || die
	fi
	elibtoolize --patch-only
}
src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake
	local myeconfargs=(
	  --disable-freetype-config
	  --enable-biarch-config
	  --enable-shared
	  $(use_with brotli)
	  $(use_with bzip2)
	  $(use_with harfbuzz)
	  $(use_with png)
	  $(use_enable static-libs static)
	  # avoid using libpng-config
	  LIBPNG_CFLAGS="$($(tc-getPKG_CONFIG) --cflags libpng)"
	  LIBPNG_LDFLAGS="$($(tc-getPKG_CONFIG) --libs libpng)"
	)
	myeconfargs+=( ac_cv_prog_RC= ac_cv_prog_ac_ct_RC= )
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
src_compile() {
	default
	if use utils; then
	  cd "${WORKDIR}/ft2demos-${PV}" || die
	  einfo "Building utils"
	  # fix for Prefix, bug #339334
	  emake \
	    X11_PATH="${EPREFIX}/usr/$(get_libdir)" \
	    FT2DEMOS=1 TOP_DIR="${S}"
	  cd "${S}" || die
	fi
}
src_install() {
	default
	if use utils; then
	  einfo "Installing utils"
	  rm "${WORKDIR}"/ft2demos-${PV}/bin/README || die
	  dodir /usr/bin #654780
	  local ft2demo
	  for ft2demo in ../ft2demos-${PV}/bin/*; do
	    libtool --mode=install $(type -P install) -m 755 "${ft2demo}" \
	      "${ED}"/usr/bin || die
	  done
	fi
	if use fontforge; then
	  # Probably fontforge needs less but this way makes things simplier...
	  einfo "Installing internal headers required for fontforge"
	  local header
	  find src/truetype include/freetype/internal -name '*.h' | \
	  while read header; do
	    mkdir -p "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
	    cp ${header} "${ED}/usr/include/freetype2/internal4fontforge/$(dirname ${header})" || die
	  done
	fi
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,INSTALL.UNIX,*.txt,PROBLEMS,TODO}
	find "${ED}" -name '*.la' -delete || die
	if ! use static-libs ; then
	  find "${ED}" -name '*.a' -delete || die
	fi
}


# vim: filetype=ebuild
