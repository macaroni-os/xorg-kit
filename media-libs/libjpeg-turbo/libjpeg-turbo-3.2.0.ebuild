# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake java-pkg-opt-2

DESCRIPTION="Main libjpeg-turbo repository"
HOMEPAGE="https://libjpeg-turbo.org"
SRC_URI="https://api.github.com/repos/libjpeg-turbo/libjpeg-turbo/tarball/3.2.0 -> libjpeg-turbo-3.2.0-c85e6b9.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="cpu_flags_arm_neon java static-libs arm amd64"
BDEPEND="dev-util/cmake
	amd64? (
	  || ( dev-lang/nasm dev-lang/yasm )
	)
	
"
RDEPEND="java? ( virual/jdk:* )
	
"
DEPEND="java? ( virual/jdk:*[-headless-awt] )
	
"

post_src_unpack() {
	mv libjpeg-turbo-libjpeg-turbo-* ${S}
}


src_prepare() {
	cmake_src_prepare
	java-pkg-opt-2_src_prepare
}
src_configure() {
	if use java ; then
	  export JAVACFLAGS="$(java-pkg_javac-args)"
	  export JNI_CFLAGS="$(java-pkg_get-jni-cflags)"
	fi
	local mycmakeargs=(
	  -DCMAKE_INSTALL_DEFAULT_DOCDIR="${EPREFIX}/usr/share/doc/${PF}"
	  -DENABLE_STATIC="$(usex static-libs)"
	  -DWITH_JAVA="$(usex java)"
	  -DWITH_MEM_SRCDST=ON
	)
	# Avoid ARM ABI issues by disabling SIMD for CPUs without NEON. #792810
	if use arm || use arm64; then
	  mycmakeargs+=(
	    -DWITH_SIMD=$(usex cpu_flags_arm_neon)
	    -DNEON_INTRINSICS=$(usex cpu_flags_arm_neon)
	  )
	fi
	if has_version -b dev-lang/yasm && ! has_version -b dev-lang/nasm; then
	  mycmakeargs+=(
	    -DCMAKE_ASM_NASM_COMPILER=$(type -P yasm)
	  )
	fi
	cmake_src_configure
}
src_install() {
	cmake_src_install
	if use java ; then
	  rm -rf "${ED}"/usr/share/java || die
	  java-pkg_dojar ${BUILD_DIR}/java/turbojpeg.jar
	fi
	find "${ED}" -type f -name '*.la' -delete || die
	local -a DOCS=( README.md ChangeLog.md )
	einstalldocs
	docinto html
	dodoc -r "${S}"/doc/turbojpeg/.
	if use java; then
	  docinto html/java
	  dodoc -r "${S}"/java/doc/.
	  newdoc "${S}"/java/README README.java
	fi
}



# vim: filetype=ebuild
