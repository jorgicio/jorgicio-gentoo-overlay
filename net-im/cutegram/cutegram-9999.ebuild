# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils ${GIT_ECLASS}

MY_PV=${PV}-stable

DESCRIPTION="A different telegram client from Aseman team forked from Sigram by Sialan Labs. "
HOMEPAGE="http://aseman.co/en/products/cutegram/"
if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/Aseman-Land/Cutegram"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Aseman-Land/Cutegram/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/Cutegram-${MY_PV}"
fi

LICENSE="GPLv3"
SLOT="0"
IUSE=""

DEPEND="
	>=net-misc/TelegramQML-0.9.1
	dev-qt/qtwebkit:5
	dev-qt/qtmultimedia:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsql:5[sqlite]
"
RDEPEND="${DEPEND}"

src_configure(){
	local myeqmakeargs=(
		Cutegram.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	emake INSTALL_ROOT="${D}" install || die "Failed installation"
}

