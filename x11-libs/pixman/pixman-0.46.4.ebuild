# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson flag-o-matic

DESCRIPTION="Low-level pixel manipulation routines"
HOMEPAGE="http://www.pixman.org/ https://gitlab.freedesktop.org/pixman/pixman/"
SRC_URI="https://www.x.org/releases/individual/lib/pixman-0.46.4.tar.xz -> pixman-0.46.4.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="cpu_flags_x86_mmxext cpu_flags_x86_sse2 cpu_flags_x86_ssse3 cpu_flags_ppc_altivec cpu_flags_arm_neon cpu_flags_arm_iwmmxt loongson2f cpu_flags_arm64_neon
"
BDEPEND="virtual/pkgconfig
	
"
DEPEND="sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	sys-devel/m4
	
"
src_configure() {
	local emesonargs=(
	  -Ddefault_library=shared
	  $(meson_feature cpu_flags_x86_mmxext mmx)
$(meson_feature cpu_flags_x86_sse2 sse2)
$(meson_feature cpu_flags_x86_ssse3 ssse3)
$(meson_feature cpu_flags_ppc_altivec vmx)
$(meson_feature cpu_flags_arm_neon neon)
$(meson_feature cpu_flags_arm64_neon a64-neon)
$(meson_feature loongson2f loongson-mmi)
-Ddemos=disabled
-Dgtk=disabled
-Dlibpng=disabled
	 )
	meson_src_configure
}


# vim: filetype=ebuild
