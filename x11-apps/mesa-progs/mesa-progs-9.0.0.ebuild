# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="https://www.mesa3d.org/ https://mesa.freedesktop.org/"
SRC_URI="https://archive.mesa3d.org/demos/mesa-demos-9.0.0.tar.xz -> mesa-demos-9.0.0.tar.xz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/9.0.0-uint.patch"
)
IUSE="egl gles2 vulkan wayland X"
REQUIRED_USE="vulkan? ( || ( X wayland ) )
"
BDEPEND="virtual/pkgconfig
	vulkan? ( dev-util/glslang )
	wayland? ( dev-util/wayland-scanner )
	
"
RDEPEND="media-libs/mesa[egl?,gles2?]
	virtual/opengl
	media-libs/libglvnd
	vulkan? ( media-libs/vulkan-loader )
	wayland? (
	  dev-libs/wayland
	  gui-libs/libdecor
	  x11-libs/libxkbcommon
	)
	X? (
	  x11-libs/libX11
	  vulkan? (
	    x11-libs/libxcb:=
	    x11-libs/libxkbcommon
	  )
	)
	
"
DEPEND="${RDEPEND}
	wayland? ( dev-libs/wayland-protocols )
	X? ( x11-base/xorg-proto )
	virtual/glu
	
"
S="${WORKDIR}/mesa-demos-9.0.0/"
src_configure() {
	local emesonargs=(
	  -Dlibdrm=disabled
	  $(meson_feature egl)
	  $(meson_feature gles2)
	  -Dgles1=disabled
	  -Dglut=disabled
	  -Dosmesa=disabled
	  $(meson_feature vulkan)
	  $(meson_feature wayland)
	  $(meson_feature X x11)
	)
	meson_src_configure
}


# vim: filetype=ebuild
