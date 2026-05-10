# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="https://dri.freedesktop.org/"
SRC_URI="https://dri.freedesktop.org/libdrm/libdrm-2.4.133.tar.xz -> libdrm-2.4.133.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="libkms valgrind video_cards_amdgpu video_cards_radeon video_cards_exynos video_cards_freedreno video_cards_intel video_cards_nouveau video_cards_omap video_cards_radeon video_cards_tegra video_cards_vc4 video_cards_vivante video_cards_vmware
"
RDEPEND="video_cards_intel? ( x11-libs/libpciaccess )
	
"
DEPEND="${RDEPEND}
	valgrind? ( dev-util/valgrind )
	
"
VIDEO_CARDS="amdgpu radeon exynos freedreno intel nouveau omap radeon tegra vc4 vivante vmware "
src_configure() {
	local emesonargs=(
	  # Udev is only used by tests now.
	  -Dudev=false
	  -Dcairo-tests=disabled
	  $(meson_feature video_cards_amdgpu amdgpu)
	  $(meson_feature video_cards_radeon radeon)
	  $(meson_feature video_cards_exynos exynos)
	  $(meson_feature video_cards_freedreno freedreno)
	  $(meson_feature video_cards_intel intel)
	  $(meson_feature video_cards_nouveau nouveau)
	  $(meson_feature video_cards_omap omap)
	  $(meson_feature video_cards_radeon radeon)
	  $(meson_feature video_cards_tegra tegra)
	  $(meson_feature video_cards_vc4 vc4)
	  $(meson_feature video_cards_vivante etnaviv)
	  $(meson_feature video_cards_vmware vmwgfx)
	  # valgrind installs its .pc file to the pkgconfig for the primary arch
	  $(meson_feature valgrind)
	)
	meson_src_configure
}


# vim: filetype=ebuild
