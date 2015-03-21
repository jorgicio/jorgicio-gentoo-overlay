# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils fdo-mime multilib

DESCRIPTION="Watch torrent movies instantly"
HOMEPAGE="http://popcorntime.io"
SRC_URI="
x86?   ( http://cdn.popcorntime.io/build/Popcorn-Time-${PV}-Linux32.tar.xz )
amd64? ( http://cdn.popcorntime.io/build/Popcorn-Time-${PV}-Linux64.tar.xz )"

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
	doexe Popcorn-Time libffmpegsumo.so nw.pak package.nw

	dosym /$(get_libdir)/libudev.so.1 /opt/${PN}/libudev.so.0
	make_wrapper ${PN} ./Popcorn-Time /opt/${PN} /opt/${PN} /opt/bin

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
