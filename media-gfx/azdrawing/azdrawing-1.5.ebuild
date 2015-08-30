# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="8bit Image Paint tool"
HOMEPAGE="http://azsky2.html.xdomain.jp/"
SRC_URI="http://osdn.jp/frs/redir.php?m=iij&f=/${PN}/63500/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXi
	virtual/jpeg"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's#^\(prefix := \)/usr/local#\1/usr#' Makefile
	sed -i -e 's#^\(bindir  := \)#\1$(DESTDIR)#' Makefile
	sed -i -e 's#^\(datadir := \)#\1$(DESTDIR)#' Makefile
	sed -i -e 's#^\(menudir := \)#\1$(DESTDIR)#' Makefile
	sed -i -e 's#^\(icondir := \)#\1$(DESTDIR)#' Makefile

	sed -i -e 's#Icon=azdrawing#Icon=/usr/share/icons/hicolor/48x48/apps/azdrawing.png#' \
		-e 's#Exec=azdrawing#Exec=/usr/bin/azdrawing#' \
		files/azdrawing.desktop

	sed -i -e 's#/usr/local/share/azdrawing#/usr/share/azdrawing/#' src/main.cpp
	sed -i 's/\/local$/\nifdef DESTDIR\n\tprefix=$(DESTDIR)\/usr\nendif/' Makefile
	sed -i 's/axt/axt .\/README .\/NEWS/' Makefile
	sed -i '/-gtk-update-icon-cache/d' Makefile
}

src_compile() {
	emake -j1 prefix="/usr"
}

src_install() {
	emake DESTDIR="${D}" install
}
