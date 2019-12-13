# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Barcode encoding library supporting over 50 symbologies"
HOMEPAGE="http://zint.org.uk"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz"
S="${WORKDIR}/${P}.src"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5"

DEPEND="
	media-libs/libpng:0
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme
"
BDEPEND="
	qt5? (
		dev-qt/qthelp:5
		dev-qt/linguist:5
		dev-qt/qdbusviewer:5
		dev-qt/designer:5
		dev-qt/assistant:5
		dev-qt/qtgui:5
	)
"

src_prepare(){
	sed -i -e "s#ZINT_VERSION_RELEASE 2#ZINT_VERSION_RELEASE 3#" CMakeLists.txt
	use !qt5 && PATCHES=( "${FILESDIR}/${P}-disable-qt.patch" )
	cmake-utils_src_prepare
}
