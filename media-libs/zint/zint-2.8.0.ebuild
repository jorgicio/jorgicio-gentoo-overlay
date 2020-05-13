# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Barcode encoding library supporting over 50 symbologies"
HOMEPAGE="http://zint.org.uk"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5"

COMMON_DEPEND="
	qt5? (
		dev-qt/qthelp:5
		dev-qt/linguist:5
		dev-qt/qdbusviewer:5
		dev-qt/designer:5
		dev-qt/assistant:5
		dev-qt/qtgui:5 )"

DEPEND="
	${COMMON_DEPEND}
	media-libs/libpng:0
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/hicolor-icon-theme
"

src_prepare(){
	sed -i -e "s#ZINT_VERSION_RELEASE 2#ZINT_VERSION_RELEASE 3#" CMakeLists.txt
	use !qt5 && PATCHES=( "${FILESDIR}/${PN}-2.6.3-disable-qt.patch" )
	cmake_src_prepare
}
