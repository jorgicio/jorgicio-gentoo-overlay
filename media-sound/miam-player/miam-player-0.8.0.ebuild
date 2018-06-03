# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="Cross-platform open source music player built with Qt5, QTav and Taglib."
HOMEPAGE="https://github.com/MBach/Miam-Player"

MY_PN="Miam-Player"

if [[ ${PV} == 9999 ]];then
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
	media-libs/qtav:0/1[pulseaudio?]
"

src_configure(){
	eqmake5 PREFIX="${EPREFIX}/usr" DESKTOPDIR="${EPREFIX}/usr/share/applications"
}

src_install(){
	emake INSTALL_DIR="${D}" install
	newicon debian/usr/share/icons/hicolor/64x64/apps/application-x-${PN//-}.png ${PN}.png
}
