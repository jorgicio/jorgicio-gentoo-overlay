# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="A minimal calendar app for Linux"
HOMEPAGE="https://github.com/echo-devim/kalendar"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archives/v${PV}/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtsql:5[sqlite]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_configure(){
	eqmake5 ${PN^}.pro
}

src_install(){
	insinto /usr/share/${PN}
	doins -r ${PN^} tools
	fperms +x /usr/share/${PN}/${PN^}
	dobin "${FILESDIR}/${PN}"
	doicon ../icon/${PN}.png
	dodoc ../README.md
	local mydesktopfields=(
		${PN}
		${PN^}
		${PN}
		"Application;Office"
	)
	make_desktop_entry ${mydesktopfields[@]}
}
