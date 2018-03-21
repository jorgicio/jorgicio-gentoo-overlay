# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils toolchain-funcs versionator

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="http://github.com/lupoDharkael/flameshot"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
fi

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-qt/qtcore-5.3.0:5
	>=dev-qt/qtdbus-5.3.0:5
	>=dev-qt/qtnetwork-5.3.0:5
	>=dev-qt/qtwidgets-5.3.0:5
"
RDEPEND="${DEPEND}"

pkg_pretend(){
	if tc-is-gcc && ! version_is_at_least 4.9.2 "$(gcc-version)" ;then
		die "You need at least GCC 4.9.2 to build this package"
	fi
}

src_prepare(){
	sed -i "s#\(VERSION = \).*#\1${PV}#" ${PN}.pro
	sed -i "s#/usr/local#/usr#" ${PN}.pro
	sed -i "s#icons#pixmaps#" ${PN}.pro
	sed -i "s#/usr/local#/usr#" docs/desktopEntry/package/${PN}.desktop
	sed -i "s#icons#pixmaps#" docs/desktopEntry/package/${PN}.desktop
	eapply_user
}

src_configure(){
	eqmake5 "CONFIG+=packaging" ${PN}.pro
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
