# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="Graphical wireless scanning for Linux"
HOMEPAGE="http://sourceforge.net/projects/linssid"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3 Boost-1.0 QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-libs/boost
	|| ( 
		<x11-libs/qwt-6.1.3-r2:6[qt5,svg,opengl]
		>=x11-libs/qwt-6.1.3-r2:6[svg,opengl]
	)
"
RDEPEND="${DEPEND}
	net-wireless/iw
	net-wireless/wireless-tools
	x11-libs/libxkbcommon[X]
	app-admin/sudo
	"

src_prepare(){
	PATCHES=( "${FILESDIR}/${P}-qwt-fix.patch" )
	default
}

src_configure(){
	eqmake5
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
