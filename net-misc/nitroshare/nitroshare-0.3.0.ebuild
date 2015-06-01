# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils eutils

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="http://${PN}.net"
SRC_URI="https://launchpad.net/${PN}/0.3/${PV}/+download/${P}.tar.gz -> ${P}.tar"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:5
		dev-qt/qtsvg:5
		 x11-libs/libnotify"
		 
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${P}"

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
