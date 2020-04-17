# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="LeoCAD is a CAD program that uses bricks similar to those found in many toys."
HOMEPAGE="http://www.leocad.org"

BASE_URI="https://github.com/leozide/leocad"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${BASE_URI}"
else
	LIB_NUM="11494"
	SRC_URI="
		${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${BASE_URI}/releases/download/v${PV}/Library-Linux-${LIB_NUM}.zip
	"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtopengl:5
	dev-qt/qtconcurrent:5
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme"

src_configure(){
	eqmake5 ${PN}.pro DISABLE_UPDATE_CHECK=1
}

src_install(){
	INSTALL_ROOT="${D}" default
	insinto /usr/share/${PN}
	doins "${WORKDIR}/library.bin"
}
