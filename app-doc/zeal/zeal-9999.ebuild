# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils git-r3

DESCRIPTION="Simple offline API documentation browser"
HOMEPAGE="http://${PN}docs.org"
SRC_URI=""
EGIT_REPO_URI="https://github.com/${PN}docs/${PN}"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE="appindicator"

DEPEND=">=dev-qt/qtwebkit-5.2.0:5
		x11-themes/hicolor-icon-theme
		dev-util/desktop-file-utils
		x11-libs/xcb-util-keysyms
		app-arch/libarchive"
RDEPEND="${DEPEND}
		appindicator? ( dev-libs/libappindicator:3 )"

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
