# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit unpacker multilib

DESCRIPTION="Beautiful desktop client for Facebook Messenger. Chat without being distracted by your feed or notifications."
HOMEPAGE="http://messengerfordesktop.com/"
MY_PN=${PN//-bin}
MY_P=${MY_PN}-${PV}
SRC_URI="
	x86? ( https://github.com/aluxian/Messenger-for-Desktop/releases/download/v${PV}/${MY_P}-linux-i386.deb )
	amd64? ( https://github.com/aluxian/Messenger-for-Desktop/releases/download/v${PV}/${MY_P}-linux-amd64.deb )
"

RESTRICT="strip mirror"

QA_PRESTRIPPED="
	opt/${MY_PN}/libffmpeg.so
	opt/${MY_PN}/${MY_PN}
	opt/${MY_PN}/libnode.so
"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs
		x11-libs/cairo
		x11-libs/gtk+:2
		gnome-base/gconf
		x11-libs/libnotify
		"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install(){
	insinto ${EPREFIX}/
	doins -r usr
	doins -r opt
	fperms +x ${EPREFIX}/opt/${MY_PN}/libnode.so
	fperms +x ${EPREFIX}/opt/${MY_PN}/${MY_PN}

}
