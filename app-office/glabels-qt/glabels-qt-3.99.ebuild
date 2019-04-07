# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

DESCRIPTION="Development version of the next major version of gLabels (4.0)"
HOMEPAGE="https://github.com/jimevins/glabels-qt"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	VERSION="continuous"
	SRC_URI="${HOMEPAGE}/archive/${VERSION}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${VERSION}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qttranslations:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/linguist:5
	dev-qt/designer:5
	dev-qt/assistant:5
	dev-qt/qdbusviewer:5
	dev-qt/qtgui:5
	media-libs/zint[qt5]
"

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
