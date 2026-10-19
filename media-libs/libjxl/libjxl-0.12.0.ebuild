# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake gnome3

DESCRIPTION="JPEG XL image format reference implementation"
HOMEPAGE="https://github.com/libjxl/libjxl"
SRC_URI="https://api.github.com/repos/libjxl/libjxl/tarball/refs/tags/v0.12.0 -> libjxl-0.12.0-a7a9c78.tar.gz"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="*"
IUSE="+gdk-pixbuf gif jpeg openexr +png"
RDEPEND="app-arch/brotli:=
	dev-cpp/highway
	media-libs/lcms:2
	gdk-pixbuf? (
	  dev-libs/glib:2
	  x11-libs/gdk-pixbuf:2
	)
	gif? ( media-libs/giflib:= )
	jpeg? ( media-libs/libjpeg-turbo:= )
	openexr? ( media-libs/openexr:= )
	png? ( media-libs/libpng:= )
	x11-misc/shared-mime-info
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv libjxl-libjxl-* ${S}
}


src_prepare() {
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DJPEGXL_ENABLE_BENCHMARK=OFF
	  -DJPEGXL_ENABLE_COVERAGE=OFF
	  -DJPEGXL_ENABLE_FUZZERS=OFF
	  -DJPEGXL_ENABLE_SJPEG=OFF
	  -DJPEGXL_WARNINGS_AS_ERRORS=OFF
	  -DCMAKE_DISABLE_FIND_PACKAGE_GIF=$(usex !gif)
	  -DCMAKE_DISABLE_FIND_PACKAGE_JPEG=$(usex !jpeg)
	  -DCMAKE_DISABLE_FIND_PACKAGE_PNG=$(usex !png)
	  -DJPEGXL_ENABLE_SKCMS=OFF
	  -DJPEGXL_ENABLE_VIEWERS=OFF
	  -DJPEGXL_FORCE_SYSTEM_BROTLI=ON
	  -DJPEGXL_FORCE_SYSTEM_GTEST=ON
	  -DJPEGXL_FORCE_SYSTEM_HWY=ON
	  -DJPEGXL_FORCE_SYSTEM_LCMS2=ON
	  -DJPEGXL_ENABLE_DOXYGEN=OFF
	  -DJPEGXL_ENABLE_MANPAGES=OFF
	  -DJPEGXL_ENABLE_JNI=OFF
	  -DJPEGXL_ENABLE_JPEGLI=OFF
	  -DJPEGXL_ENABLE_JPEGLI_LIBJPEG=OFF
	  -DJPEGXL_ENABLE_TCMALLOC=OFF
	  -DJPEGXL_ENABLE_EXAMPLES=OFF
	  -DJPEGXL_ENABLE_TOOLS=ON
	  -DJPEGXL_ENABLE_OPENEXR=$(usex openexr)
	  -DJPEGXL_ENABLE_PLUGINS=ON
	  -DJPEGXL_ENABLE_PLUGIN_GDKPIXBUF=$(usex gdk-pixbuf)
	  -DJPEGXL_ENABLE_PLUGIN_GIMP210=OFF
	  -DJPEGXL_ENABLE_PLUGIN_MIME=OFF
	  -DBUILD_TESTING=OFF
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	find "${ED}" -name '*.a' -delete || die
}
pkg_postinst() {
	use gdk-pixbuf && gnome3_pkg_postinst
}
pkg_postrm() {
	use gdk-pixbuf && gnome3_pkg_postrm
}



# vim: filetype=ebuild
