# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/ https://gitlab.freedesktop.org/wayland/wayland-protocols"
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/1.45/wayland-protocols-1.45.tar.bz2 -> wayland-protocols-1.45.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="virtual/pkgconfig
	dev-util/wayland-scanner
	
"
S="${WORKDIR}/wayland-protocols-1.45"

# vim: filetype=ebuild
