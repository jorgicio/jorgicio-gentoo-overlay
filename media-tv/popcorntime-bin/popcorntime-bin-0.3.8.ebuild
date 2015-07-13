# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime multilib

DESCRIPTION="Watch torrent movies instantly"
HOMEPAGE="http://popcorntime.io"
SRC_URI="
x86?   ( 
	http://104.236.185.158/build/Popcorn-Time-${PV}-0-Linux-32.tar.xz
	http://104.131.222.157/build/Popcorn-Time-${PV}-0-Linux-32.tar.xz
)
amd64? ( 
	http://104.236.185.158/build/Popcorn-Time-${PV}-0-Linux-64.tar.xz
	http://104.131.222.157/build/Popcorn-Time-${PV}-0-Linux-64.tar.xz
	)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="splitdebug strip"

DEPEND=""
RDEPEND="dev-libs/nss
	gnome-base/gconf
	media-fonts/corefonts
	media-libs/alsa-lib
	x11-libs/gtk+:2
	net-libs/nodejs"

S="${WORKDIR}"

src_install() {
	exeinto /opt/${PN}
	doexe Popcorn-Time
	
	insinto /opt/${PN}
	doins -r src node_modules icudtl.dat locales LICENSE.txt libffmpegsumo.so nw.pak install

	dosym /$(get_libdir)/libudev.so.1 /opt/${PN}/libudev.so.0
	dosym /opt/${PN}/Popcorn-Time /usr/bin/${PN}

	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/popcorntime.png
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
