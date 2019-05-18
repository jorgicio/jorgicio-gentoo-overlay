# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="An x-cursor theme inspired by macOS and based on KDE Breeze"
HOMEPAGE="https://github.com/keeferrourke/capitaine-cursors"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PV="r${PV}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux ~x86-fbsd ~amd64-fbsd ~arm ~arm64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="build"

BDEPEND="
	build? (
		x11-apps/xcursorgen
		media-gfx/inkscape
	)
"
DEPEND=""
RDEPEND="${DEPEND}"

src_compile(){
	use build && ./build.sh
}

src_install(){
	insinto /usr/share/icons/${PN}
	doins -r dist/*
	insinto /usr/share/icons/${PN}-white
	doins -r dist-white/*
}
