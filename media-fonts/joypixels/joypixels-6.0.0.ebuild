# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Emoji as a Service (formerly EmojiOne)"
HOMEPAGE="https://www.joypixels.com"
SRC_URI="https://cdn.joypixels.com/arch-linux/font/${PV}/joypixels-android.ttf -> ${P}.ttf"

LICENSE="JoyPixels"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

FONT_SUFFIX="ttf"
S="${WORKDIR}"
FONT_S="${S}"

src_unpack() {
	true
}

src_prepare() {
	cp "${DISTDIR}/${P}.ttf" "${WORKDIR}/JoyPixels.ttf" || die
	default
}
