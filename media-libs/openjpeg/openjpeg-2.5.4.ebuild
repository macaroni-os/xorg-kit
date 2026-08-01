# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake flag-o-matic

DESCRIPTION="Official repository of the OpenJPEG project"
HOMEPAGE="https://github.com/uclouvain/openjpeg"
SRC_URI="https://api.github.com/repos/uclouvain/openjpeg/tarball/v2.5.4 -> openjpeg-2.5.4-6c4a29b.tar.gz"
LICENSE="NOASSERTION"
SLOT="2/7"
KEYWORDS="*"
DOCS=(
	AUTHORS.md
	CHANGELOG.md
	NEWS.md
	README.md
	THANKS.md
)
IUSE="doc"
BDEPEND="doc? ( app-doc/doxygen )
	
"
RDEPEND="media-libs/lcms:2
	media-libs/libpng:0=
	media-libs/tiff:=
	sys-libs/zlib:=
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv uclouvain-openjpeg-* ${S}
}


src_prepare() {
	rm -r thirdparty/lib* thirdparty/include || die
	cmake_src_prepare
}
src_configure() {
	append-lfs-flags
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DBUILD_DOC=$(usex doc ON OFF)
	  -DBUILD_CODEC=ON
	  -DBUILD_STATIC_LIBS=OFF
	  -DBUILD_THIRDPARTY=OFF
	)
	cmake_src_configure
}



# vim: filetype=ebuild
