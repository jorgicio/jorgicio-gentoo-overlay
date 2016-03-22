# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit base toolchain-funcs multilib

DESCRIPTION="Successor of clalsadrv. API providing easy access to ALSA PCM devices"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

DOCS=(AUTHORS README)

PATCHES=("${FILESDIR}"/${P}-Makefile.patch)

src_compile() {
	tc-export CXX
	emake -C libs
	emake -C apps
}

src_install() {
	emake -C libs DESTDIR="${D}" LIBDIR="$(get_libdir)" PREFIX="${EPREFIX}/usr" install
	emake -C apps DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	base_src_install_docs
}
