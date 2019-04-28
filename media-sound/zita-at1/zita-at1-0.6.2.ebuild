# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
inherit toolchain-funcs

DESCRIPTION="An autotuner, normally used to correct the pitch of a voice singing (slightly) out of tune"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pkgconf"

DEPEND=">=media-libs/libclthreads-2.4.0
	>=media-libs/libclxclient-3.6.1
	>=media-libs/zita-resampler-1.1.0
	media-sound/jack-audio-connection-kit
	>=sci-libs/fftw-3.2.2:3.0"
RDEPEND="${RDEPEND}"
BDEPEND="pkgconf? ( dev-util/pkgconf )"


S="${WORKDIR}/${P}/source"
RESTRICT="mirror"

DOCS=(../AUTHORS ../COPYING)
HTML_DOCS=(../doc/)

src_prepare(){
	use !pkgconf && sed -i -e "s#pkgconf#pkg-config#" Makefile
	default_src_prepare
}

src_compile() {
	CXX="$(tc-getCXX)" PREFIX="${EPREFIX}/usr" default_src_compile
}

src_install(){
	PREFIX="${EPREFIX}/usr" default_src_install
}
