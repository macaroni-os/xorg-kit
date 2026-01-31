# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
SRC_URI="https://api.github.com/repos/NVIDIA/libglvnd/tarball/refs/tags/v1.7.0 -> libglvnd-1.7.0-faa23f2.tar.gz"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/libglvnd-1.7.0-backport-pr291.patch"
)
IUSE="+asm +egl +gles +gles2 +glx +headers tls +X"
BDEPEND="${PYTHON_DEPS}
	
"
RDEPEND="X? (
	  x11-libs/libX11
	  x11-libs/libXext
	)
	
"
DEPEND="${RDEPEND}
	X? (
	  x11-base/xorg-proto
	)
	
"

post_src_unpack() {
	mv NVIDIA-libglvnd-* ${S}
}


src_prepare() {
	default
	sed -i -e "/^PLATFORM_SYMBOLS/a \    '__gentoo_check_ldflags__'," bin/symbols-check.py || die
}
src_configure() {
	local emesonargs=(
	  -Dasm=$(usex asm enabled disabled)
	  -Degl=$(usex egl true false)
	  -Dgles1=$(usex gles true false)
	  -Dgles2=$(usex gles2 true false)
	  -Dglx=$(usex glx enabled disabled)
	  -Dheaders=$(usex headers true false)
	  -Dtls=$(usex tls true false)
	  -Dx11=$(usex X enabled disabled)
	)
	use elibc_musl && emesonargs+=( -Dtls=false )
	meson_src_configure
}
src_compile() {
	meson_src_compile
}
src_install() {
	meson_src_install
}



# vim: filetype=ebuild
