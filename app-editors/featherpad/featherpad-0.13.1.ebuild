# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="Lightweight Qt5 plain-text editor for Linux"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
SRC_URI="${HOMEPAGE}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

S="${WORKDIR}/${P/featherpad/FeatherPad}"

src_configure(){
	eqmake5 "fp.pro"
}

src_install(){
	INSTALL_ROOT="${ED%/}" default
}
