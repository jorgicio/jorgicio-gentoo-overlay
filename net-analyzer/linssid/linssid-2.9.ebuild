# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="Graphical wireless scanning for Linux"
HOMEPAGE="http://sourceforge.net/projects/linssid"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-3.0"
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
	epatch "${FILESDIR}/${P}-qwt-fix.patch"
	eapply_user
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
