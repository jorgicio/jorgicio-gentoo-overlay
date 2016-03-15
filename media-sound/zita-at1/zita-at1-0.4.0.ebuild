# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit base toolchain-funcs

DESCRIPTION="An autotuner, normally used to correct the pitch of a voice singing (slightly) out of tune"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/libclthreads-2.4.0
	>=media-libs/libclxclient-3.6.1
	>=media-libs/zita-resampler-1.1.0
	media-sound/jack-audio-connection-kit
	>=sci-libs/fftw-3.2.2:3.0"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/source"
RESTRICT="mirror"

DOCS=(../AUTHORS ../README)
HTML_DOCS=(../doc/)

PATCHES=("${FILESDIR}/${P}-Makefile.patch")

src_compile() {
	CXX="$(tc-getCXX)" base_src_make PREFIX="${EPREFIX}/usr"
}

src_install() {
	base_src_install PREFIX="${EPREFIX}/usr"
}
