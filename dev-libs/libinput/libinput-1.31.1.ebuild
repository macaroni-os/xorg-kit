# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Library to handle input devices in Wayland"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/libinput https://gitlab.freedesktop.org/libinput/libinput"
SRC_URI="https://gitlab.freedesktop.org/libinput/libinput/-/archive/1.31.1/libinput-1.31.1.tar.bz2 -> libinput-1.31.1.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="input_devices_wacom"
RDEPEND="input_devices_wacom? ( dev-libs/libwacom )
	>=dev-libs/libevdev-1.10.0
	sys-libs/mtdev
	virtual/libudev:=
	virtual/udev
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Ddebug-gui=false
	  -Ddocumentation=false
	  $(meson_use input_devices_wacom libwacom)
	  -Dtests=false # tests are restricted
	  -Dudev-dir="$(get_udevdir)"
	)
	meson_src_configure
}
pkg_postinst() {
	udevadm hwdb --update --root="${ROOT}"
}


# vim: filetype=ebuild
