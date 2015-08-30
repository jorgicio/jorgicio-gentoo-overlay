# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="PNG Convert"
HOMEPAGE="http://azsky2.html.xdomain.jp/"
SRC_URI="http://osdn.jp/frs/redir.php?m=iij&f=/${PN}/57793/azcvpng-${PV}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	media-libs/fontconfig
	media-libs/freetype"
RDEPEND="${DEPEND}"

S="${WORKDIR}/azcvpng-${PV}-src"

src_prepare() {
	sed -i -e 's#Exec=azcvpng#Exec=/usr/bin/azcvpng#' \
		files/azconvpng.desktop
	sed -i -e 's/-lz/-lz -lfontconfig/' Makefile
}

src_compile() {
	emake -j1 prefix="/usr"
}

src_install() {
	emake prefix="${D}/usr" install
}
