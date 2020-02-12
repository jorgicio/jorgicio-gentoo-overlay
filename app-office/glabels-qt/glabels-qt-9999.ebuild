# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg

DESCRIPTION="Development version of the next major version of gLabels (4.0)"
HOMEPAGE="https://github.com/jimevins/glabels-qt"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MASTER_VERSION="master558"
	MY_PV="${PV:0:4}-${MASTER_VERSION}"
	MY_P="${PN/-qt}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_P}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
    app-text/barcode
	dev-qt/qtcore:5
	dev-qt/qttranslations:5
	dev-qt/linguist:5
	dev-qt/designer:5
	dev-qt/assistant:5
	dev-qt/qdbusviewer:5
	dev-qt/qtgui:5
	media-gfx/qrencode
	<media-libs/zint-2.7[qt5]
"
RDEPEND="${DEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}
