# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit base eutils toolchain-funcs

DESCRIPTION="Zita-rev1 is a reworked version of the reverb originally developed for Aeolus"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
#SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"
SRC_URI="http://download.tuxfamily.org/proaudio/distfiles/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=media-libs/libclthreads-2.4.0
	>=media-libs/libclxclient-3.6.1
	media-sound/jack-audio-connection-kit"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"

PATCHES=("${FILESDIR}/${P}-makefile.patch")

src_compile() {
	CXX="$(tc-getCXX)" emake PREFIX=/usr || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die

	dodoc ../AUTHORS ../README

	if use doc ; then
		cd ../doc
		dohtml -r *
	fi
}
