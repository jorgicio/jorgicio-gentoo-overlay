# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Nostalgia bucklespring keyboard sound, sampled from IBM's Model-M"
HOMEPAGE="http://github.com/zevv/bucklespring"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="wayland"

DEPEND="
	media-libs/openal
	x11-libs/libXtst
	media-libs/alure
	wayland? (
		dev-libs/wayland
		x11-drivers/xf86-input-libinput
	)
"
RDEPEND="${DEPEND}"

src_compile(){
	local mymakeflags="PATH_AUDIO=${EPREFIX}/usr/share/${PN}"
	use wayland && mymakeflags+=" libinput=1"
	emake ${mymakeflags}
}

src_install(){
	dobin buckle
	insinto ${EPREFIX}/usr/share/${PN}
	doins -r wav/*
}

pkg_postinst(){
	echo
	einfo "In order to run the program, simply run the 'buckle' binary"
	echo
}
