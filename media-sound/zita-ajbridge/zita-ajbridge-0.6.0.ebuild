# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit base toolchain-funcs

DESCRIPTION="Bridge ALSA devices to Jack clients, to provide additional capture (a2j) or playback (j2a) channels"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/alsa-lib
	>=media-libs/zita-alsa-pcmi-0.2.0
	>=media-libs/zita-resampler-1.3.0
	media-sound/jack-audio-connection-kit"

S=${WORKDIR}/${P}/source
RESTRICT="mirror"

DOCS=(../AUTHORS ../README)

PATCHES=("${FILESDIR}"/${PN}-0.4.0-Makefile.patch)

src_compile() {
	CXX="$(tc-getCXX)" base_src_make
}

src_install() {
	base_src_install PREFIX="${EPREFIX}/usr"
}
