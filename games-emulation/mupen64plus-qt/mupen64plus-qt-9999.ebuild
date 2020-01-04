# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg

DESCRIPTION="A customizable Qt5-based launcher for Mupen64Plus"
HOMEPAGE="https://github.com/dh4/mupen64plus-qt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

DEPEND="
	dev-libs/quazip
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	games-emulation/mupen64plus-audio-sdl
	games-emulation/mupen64plus-core
	games-emulation/mupen64plus-input-sdl
	games-emulation/mupen64plus-rsp-hle
	|| (
		games-emulation/mupen64plus-video-glide64mk2
		games-emulation/mupen64plus-video-rice
	)
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme"


src_configure() {
	eqmake5
}

src_install() {
	default
	dobin ${PN}
	domenu resources/${PN}.desktop
	newicon -t hicolor -s 128 resources/images/mupen64plus.png ${PN}.png
}
