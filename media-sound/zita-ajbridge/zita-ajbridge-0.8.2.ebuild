# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit toolchain-funcs

DESCRIPTION="Bridge ALSA devices to Jack clients, to provide additional capture (a2j) or playback (j2a) channels"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/alsa-lib
	>=media-libs/zita-alsa-pcmi-0.2.0
	>=media-libs/zita-resampler-1.3.0
	media-sound/jack-audio-connection-kit"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"

DOCS=(../AUTHORS ../COPYING ../README)

src_compile() {
	CXX="$(tc-getCXX)" default_src_compile
}

src_install() {
	PREFIX=${EPREFIX}/usr default_src_install
}
