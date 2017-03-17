# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="An x-cursor theme inspired by macOS and based on KDE Breeze"
HOMEPAGE="https://github.com/keeferrourke/capitaine-cursors"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	MY_PV="r${PV}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux ~x86-fbsd ~amd64-fbsd"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="build"

DEPEND="
	build? (
		x11-apps/xcursorgen
		media-gfx/inkscape
	)
"
RDEPEND="${DEPEND}"

src_compile(){
	if use build;then
		cd src
		./build.sh
		cd ..
	fi
}

src_install(){
	insinto /usr/share/icons/${PN}
	if use build;then
		doins -r src/build/*
	else
		doins -r bin/xcursors/*
	fi
}
