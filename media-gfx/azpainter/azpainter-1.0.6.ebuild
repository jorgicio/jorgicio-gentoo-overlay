# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Full Color Paint tool"
HOMEPAGE="http://azsky2.html.xdomain.jp/"
SRC_URI="http://osdn.jp/frs/redir.php?m=iij&f=/${PN}/63501/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXi
	virtual/jpeg
	media-libs/libjpeg-turbo"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#Icon=azpainter#Icon=/usr/share/icons/hicolor/48x48/apps/azpainter.png#' \
		-e 's#Exec=azpainter#Exec=/usr/bin/azpainter#' \
		files/azpainter.desktop
	sed -i 's/\/local$/\nifdef DESTDIR\n\tprefix=$(DESTDIR)\/usr\nendif/' Makefile
	sed -i 's/axt/axt .\/README .\/NEWS/' Makefile
	sed -i '/-gtk-update-icon-cache/d' Makefile
}

src_compile() {
	emake -j1 prefix="/usr"
}

src_install() {
	emake prefix="${D}/usr" install
}
