# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils eutils git-r3

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="http://${PN}.net"
SRC_URI=""
GIT_REPO_URI="https://github.com/${PN}/${PN}-desktop"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="indicator"

DEPEND="dev-qt/qtcore:5
		dev-qt/qtsvg:5
		 x11-libs/libnotify"
		 
RDEPEND="${DEPEND}
		indicator? (
			x11-libs/gtk+:2
			dev-libs/libappindicator:2
			x11-libs/libnotify
		)"

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
