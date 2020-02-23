# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

MY_PN="${PN/-bin}"
UNICODE_VERSION="12"
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}-unicode${UNICODE_VERSION}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Google Noto Emoji fonts (binary version)"
HOMEPAGE="https://www.google.com/get/noto https://github.com/googlei18n/noto-emoji"
SRC_URI="https://github.com/googlei18n/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="!media-fonts/noto-emoji"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}/fonts"
FONT_SUFFIX="ttf"
FONT_PN="${MY_PN}"
FONTDIR="/usr/share/fonts/${FONT_PN}"

src_prepare() {
	rm fonts/LICENSE fonts/NotoEmoji-Regular.ttf Makefile || die
	default
}

src_install() {
	font_src_install
	insinto /usr/share/icons/"${PN/-bin}"/128x128/emotes/
	doins png/128/*.png

	insinto /usr/share/icons/"${PN/-bin}"/scalable/emotes/
	doins svg/*.svg
}
