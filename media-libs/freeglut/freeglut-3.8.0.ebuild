# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Free implementation of the OpenGL Utility Toolkit (GLUT)"
HOMEPAGE="http://freeglut.sourceforge.net"
SRC_URI="https://api.github.com/repos/freeglut/freeglut/tarball/refs/tags/v3.8.0 -> freeglut-3.8.0-3db1649.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="virtual/glu
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	
"

post_src_unpack() {
	mv freeglut-freeglut-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  "-DFREEGLUT_GLES=OFF"
	  "-DFREEGLUT_BUILD_DEMOS=OFF"
	  "-DFREEGLUT_BUILD_STATIC_LIBS=$(usex static-libs ON OFF)"
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	cp "${ED}"/usr/$(get_libdir)/pkgconfig/{,free}glut.pc || die
}



# vim: filetype=ebuild
