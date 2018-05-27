# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Simple image comparison tool"
HOMEPAGE="https://sourceforge.net/projects/diffimg"
SRC_URI="mirror://sourceforge/${PN}/${P^}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${P^}-src"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	x11-libs/qwt[qt4,svg]
	media-libs/opencv[png]
"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i -e 's/\r//' \
		-e 's/|/-print0 |/' \
		-e "s#dos2unix#-0 sed -i 's|\\\r||'#" \
		./tounix.sh || die
	sh ./tounix.sh || die
	default
}

src_configure(){
	cd "${S}/build"
	eqmake4 -recursive
}

src_compile(){
	cd "${S}/build"
	emake
}

src_install(){
	cd "${S}/build"
	emake INSTALL_ROOT="${D}" install
}
