# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MIN_VERSION="2.8.12"
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit cmake-utils python-single-r1 xdg-utils

DESCRIPTION="Screenshot capturing and sharing tool over various services"
HOMEPAGE="https://screencloud.net"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/olav-st/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/olav-st/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="libressl"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=dev-python/PythonQt-3.2[extensions]
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
"

RDEPEND="${DEPEND}
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
"
DOCS=( README.md )

src_prepare(){
	cmake-utils_src_prepare
}

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}
