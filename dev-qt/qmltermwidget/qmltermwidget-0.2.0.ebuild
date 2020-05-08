# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="QML port of x11-libs/qtermwidget"
HOMEPAGE="https://github.com/Swordfish90/qmltermwidget"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Swordfish90/${PN}"
else
	SRC_URI="https://github.com/Swordfish90/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtdeclarative:5=
	dev-qt/qtwidgets:5=
"
RDEPEND="${DEPEND}"

src_configure(){
	eqmake5
}

src_install(){
	INSTALL_ROOT="${D}" default
}
