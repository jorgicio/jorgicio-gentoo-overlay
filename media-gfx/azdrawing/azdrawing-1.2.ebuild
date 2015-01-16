# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="8bit Image Paint tool"
HOMEPAGE="http://hp.vector.co.jp/authors/VA033749/linux/index.html"
SRC_URI="mirror://sourceforge.jp/azdrawing/60114/${P}-src.tar.bz2"

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
	sed -i -e 's#Icon=azdrawing#Icon=/usr/share/icons/hicolor/48x48/apps/azdrawing.png#' \
		-e 's#Exec=azdrawing#Exec=/usr/bin/azdrawing#' \
		files/azdrawing.desktop

	sed -i -e 's#/usr/local/share/azdrawing#/usr/share/azdrawing/#' src/main.cpp
}

src_compile() {
	emake -j1 prefix="/usr" CXX=$(tc-getBUILD_CXX) CXXFLAGS="${CXXFLAGS}" LFLAGS=""
}

src_install() {
	emake DESTDIR="${D}" install
}
