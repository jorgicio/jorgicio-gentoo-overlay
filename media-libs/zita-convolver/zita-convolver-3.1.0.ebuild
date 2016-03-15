# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit base multilib toolchain-funcs

DESCRIPTION="A high performance audio signal convolver library"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sci-libs/fftw:3.0"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	tc-export CXX
	emake -C libs NOOPTIMIZE=1
}

src_install() {
	emake -C libs DESTDIR="${D}" PREFIX="${EPREFIX}"/usr \
		LIBDIR="$(get_libdir)" LDCONFIG= install
	dodoc AUTHORS README
}
