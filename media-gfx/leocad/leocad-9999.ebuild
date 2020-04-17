# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="LeoCAD is a CAD program that uses bricks similar to those found in many toys."
HOMEPAGE="https://www.leocad.org"

PARTS_LIB="11494"
PARTS_RECENT_VERSION="18.02"
SRC_URI="https://github.com/leozide/${PN}/releases/download/v${PARTS_RECENT_VERSION}/Library-Linux-${PARTS_LIB}.zip "

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leozide/${PN}"
else
	SRC_URI+="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
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

pkg_postinst(){
	echo
	elog "LeoCAD uses its default Parts Library, but it's compatible with LDraw's ones."
	elog "See https://www.leocad.org/docs/library.html for more information about installation."
	elog "As alternative, you can install the media-gfx/ldraw package."
	echo
	xdg_pkg_postinst
}
