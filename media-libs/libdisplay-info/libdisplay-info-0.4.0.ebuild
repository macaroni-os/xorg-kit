# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-any-r1

DESCRIPTION=""
SRC_URI="https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/0.4.0/libdisplay-info-0.4.0.tar.bz2 -> libdisplay-info-0.4.0.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	sys-apps/hwdata
	virtual/pkgconfig
	
"

# vim: filetype=ebuild
