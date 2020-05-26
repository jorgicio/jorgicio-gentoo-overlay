# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="The system font for macOS, iOS, watchOS and tvOS"
HOMEPAGE="https://developer.apple.com/fonts/"
SRC_URI="https://developer.apple.com/fonts/downloads/SFPro.zip -> SFPro-${PV}.zip"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="APSL-2"
RESTRICT="mirror"

S="${WORKDIR}"
FONT_S="${S}/Library/Fonts"
FONT_SUFFIX="otf"

DEPEND="app-arch/libarchive[bzip2]"

src_unpack() {
	default
	bsdtar xvPf "${WORKDIR}"/SFPro/'San Francisco Pro.pkg' || die
	bsdtar xvPf "${WORKDIR}"/'San Francisco Pro.pkg/Payload' || die
}
