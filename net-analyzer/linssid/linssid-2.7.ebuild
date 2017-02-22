# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Graphical wireless scanning for Linux"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3 Boost-1.0 QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+sudo"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-libs/boost
	x11-libs/qwt:6[qt5,svg,opengl]
"
RDEPEND="${DEPEND}
	net-wireless/iw
	net-wireless/wireless-tools
	x11-libs/libxkbcommon[X]
	sudo? ( app-admin/sudo )
	"

src_prepare(){
	#Some workarounds
	sed -i -e 's/QT_STATIC_CONST/static const/g' qwt-lib/src/qwt_transform.h
	sed -i -e 's/QT_STATIC_CONST_IMPL/const/g' qwt-lib/src/qwt_transform.cpp
	sed -i -e 's/\:libboost\_regex\.a/boost_regex/g' ${PN}-app/${PN}-app.pro
}

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
	emake INSTALL_ROOT="${D}" install
}
