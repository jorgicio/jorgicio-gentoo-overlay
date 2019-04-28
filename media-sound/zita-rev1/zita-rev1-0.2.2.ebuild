# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit toolchain-funcs

DESCRIPTION="Zita-rev1 is a reworked version of the reverb originally developed for Aeolus"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pkgconf"

DEPEND=">=media-libs/libclthreads-2.4.0
	>=media-libs/libclxclient-3.6.1
	media-sound/jack-audio-connection-kit"
RDEPEND="${RDEPEND}"
BDEPEND="pkgconf? ( dev-util/pkgconf )"

S="${WORKDIR}/${P}/source"
DOCS=( ../AUTHORS ../COPYING )
HTML_DOCS=( ../doc )

src_prepare(){
	use !pkgconf && sed -i -e "s#pkgconf#pkg-config#" Makefile
	default_src_prepare
}

src_compile() {
	CXX="$(tc-getCXX)" PREFIX=${EPREFIX}/usr default_src_compile
}

src_install() {
	PREFIX=${EPREFIX}/usr default_src_install
}
