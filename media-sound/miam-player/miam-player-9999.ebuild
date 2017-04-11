# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="Cross-platform open source music player built with Qt5, QTav and Taglib."
HOMEPAGE="http://www.miam-player.org"

MY_PN=(${PN//-/ })
MY_PN="${MY_PN[@]^}"
MY_PN="${MY_PN/ /-}"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MBach/${MY_PN}"
	SRC_URI=""
	KEYWORDS=""
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/MBach/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="pulseaudio"

DEPEND="
	dev-qt/qtmultimedia:5[alsa,pulseaudio?,gstreamer]
	dev-qt/qtx11extras:5
"
RDEPEND="${DEPEND}
	media-libs/taglib
	media-video/QtAV
"

src_configure(){
	local myconf=(
		${PN}.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myconf[@]}
}

src_install(){
	emake INSTALL_ROOT="${D}" install
	newicon debian/usr/share/icons/hicolor/64x64/apps/application-x-${PN//-}.png ${PN}.png
}
