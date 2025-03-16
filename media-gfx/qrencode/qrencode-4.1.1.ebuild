# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="https://fukuchi.org/works/qrencode/"
SRC_URI="https://github.com/fukuchi/libqrencode/tarball/715e29fd4cd71b6e452ae0f4e36d917b43122ce8 -> libqrencode-4.1.1-715e29f.tar.gz"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="*"
IUSE=""

RDEPEND="media-libs/libpng:0="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

post_src_unpack() {
	mv fukuchi-libqrencode-* "${S}"
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-tests
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

# vim: filetype=ebuild