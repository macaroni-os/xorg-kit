# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Color management engine supporting ICC profiles"
HOMEPAGE="https://www.littlecms.com/"
SRC_URI="https://downloads.sourceforge.net/project/lcms/lcms/2.19/lcms2-2.19.tar.gz -> lcms2-2.19.tar.gz"
LICENSE="MIT"
SLOT="2"
KEYWORDS="*"
IUSE="doc jpeg static-libs tiff"
RDEPEND="jpeg? ( media-libs/libjpeg-turbo:= )
	tiff? ( media-libs/tiff:= )
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/lcms2-2.19"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=$(usex static-libs both shared)
	  -Dthreaded=true
	  -Dfastfloat=true
	  -Dutils=true
	  -Dtests=disabled
	  $(meson_feature jpeg)
	  $(meson_feature tiff)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	use doc && dodoc doc/*.pdf
}


# vim: filetype=ebuild
