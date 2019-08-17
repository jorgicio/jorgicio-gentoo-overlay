# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Hsiu-Ming graphical shutdown timer"
HOMEPAGE="https://cges30901.github.io/hmtimer-website"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cges30901/${PN}"
else
	SRC_URI="https://github.com/cges30901/${PN}/releases/download/v${PV}/${P}-src.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme"

src_configure() {
	eqmake5
}

src_install() {
	INSTALL_ROOT="${D}" default_src_install
	doman ${PN}.1
}
