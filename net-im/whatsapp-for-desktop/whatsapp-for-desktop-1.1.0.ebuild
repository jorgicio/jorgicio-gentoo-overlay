# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker multilib

DESCRIPTION="Unofficial and beautiful desktop client for Whatsapp Messenger."
HOMEPAGE="http://${PN}.com/"
SRC_URI="
	x86? ( https://github.com/Aluxian/Whatsapp-Desktop/releases/download/v${PV}/UnofficialWhatsapp_linux32.deb )
	amd64? ( https://github.com/Aluxian/Whatsapp-Desktop/releases/download/v${PV}/UnofficialWhatsapp_linux64.deb  )
"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs
		x11-libs/cairo
		gnome-base/gconf
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
	doins opt/WhatsAppForDesktop/whatsappfordesktop.desktop
	fperms +x ${EPREFIX}/opt/WhatsAppForDesktop/after-install.sh
	fperms +x ${EPREFIX}/opt/WhatsAppForDesktop/after-remove.sh
	fperms +x ${EPREFIX}/opt/WhatsAppForDesktop/libffmpegsumo.so
	fperms +x ${EPREFIX}/opt/WhatsAppForDesktop/UnofficialWhatsApp
	fperms +x ${EPREFIX}/opt/WhatsAppForDesktop/nw.pak

}
