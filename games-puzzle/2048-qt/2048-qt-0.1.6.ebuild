# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit qmake-utils

DESCRIPTION="A Qt-based version of the game 2048"
HOMEPAGE="https://github.com/xiaoyong/2048-Qt"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols[widgets]
	x11-themes/hicolor-icon-theme"
RDEPEND="${DEPEND}"

S="${WORKDIR}/2048-Qt-${PV}"

src_configure(){
	local myeqmakeargs=(
		${PN}.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	dobin ${PN}
	for size in 16x16 32x32 48x48 256x256;do
		doicon -s $size res/icons/$size/apps/${PN}.png
	done
	doicon res/icons/scalable/apps/${PN}.svg
	domenu res/${PN}.desktop
	doman res/man/${PN}.6
}
