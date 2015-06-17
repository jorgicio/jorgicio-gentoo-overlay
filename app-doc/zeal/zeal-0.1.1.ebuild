# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="Simple offline API documentation browser"
HOMEPAGE="http://${PN}docs.org"
SRC_URI="https://github.com/${PN}docs/${PN}/archive/v${PV}.tar.gz"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="indicator"

DEPEND=">=dev-qt/qtwebkit-5.2.0:5
		x11-themes/hicolor-icon-theme
		dev-util/desktop-file-utils
		x11-libs/xcb-util-keysyms
		app-arch/libarchive"
RDEPEND="${DEPEND}
		indicator? ( dev-libs/libappindicator:3 )"

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
