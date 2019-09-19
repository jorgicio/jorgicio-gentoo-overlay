# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Fun and new monospaced font with programming ligatures by Microsoft"
HOMEPAGE="https://github.com/microsoft/cascadia-code"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/Cascadia.ttf -> ${P}.ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

S="${WORKDIR}"
FONT_SUFFIX="ttf"
FONT_S="${S}"

src_unpack() {
	# Nothing to unpack
	true
}

src_prepare() {
	# In order to avoid confusions, better re-rename
	# the font to its original name and copy it to ${S}.
	cp ${DISTDIR}/${P}.ttf ${S}/Cascadia.ttf || die
	default
}
