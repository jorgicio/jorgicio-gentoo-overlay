# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker multilib

DESCRIPTION="Beautiful desktop client for Facebook Messenger. Chat without being distracted by your feed or notifications."
HOMEPAGE="http://messengerfordesktop.com/"
SRC_URI="
	x86? ( https://github.com/Aluxian/Facebook-Messenger-Desktop/releases/download/v${PV}/Messenger_linux32.deb )
	amd64? ( https://github.com/Aluxian/Facebook-Messenger-Desktop/releases/download/v${PV}/Messenger_linux64.deb  )
"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs
		x11-libs/cairo
		x11-libs/gtk+:2
		x11-libs/libnotify
		"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack "${A}"
	unpack ./data.tar.gz
	rm -v control.tar.gz data.tar.gz debian-binary
}

src_install(){
	insinto ${EPREFIX}/
	doins -r usr
	doins -r opt
	insinto ${EPREFIX}/usr/share/applications
	doins opt/MessengerForDesktop/messengerfordesktop.desktop
	fperms +x ${EPREFIX}/opt/MessengerForDesktop/after-install.sh
	fperms +x ${EPREFIX}/opt/MessengerForDesktop/after-remove.sh
	fperms +x ${EPREFIX}/opt/MessengerForDesktop/libffmpegsumo.so
	fperms +x ${EPREFIX}/opt/MessengerForDesktop/Messenger
	fperms +x ${EPREFIX}/opt/MessengerForDesktop/nw.pak

}
