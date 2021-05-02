# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake eutils xdg

QTMIN=5.12.0

DESCRIPTION="Lightweight Qt5 plain-text editor for Linux"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
SRC_URI="${HOMEPAGE}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="X"

RDEPEND="
	>=app-text/hunspell-1.6:=
	>=dev-qt/qtcore-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtprintsupport-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	X? (
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXext
	)
"
DEPEND="${RDEPEND}
	>=dev-qt/linguist-tools-${QTMIN}:5
	virtual/pkgconfig
"

S="${WORKDIR}/${P/featherpad/FeatherPad}"

src_prepare() {
	cmake_src_prepare
	xdg_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITHOUT_X11=$(usex X OFF ON)
	)
	cmake_src_configure
}
