# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker xdg-utils gnome2-utils eutils

DESCRIPTION="Private messaging from your desktop (Binary version)"
HOMEPAGE="https://www.signal.org/"
MY_PN="${PN//-bin}"
SRC_URI="
	amd64? ( https://updates.signal.org/desktop/apt/pool/main/${PN:0:1}/${MY_PN}/${MY_PN}_${PV}_amd64.deb )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror strip bindist"

QA_PRESTRIPPED="opt/Signal/${MY_PN}"
QA_PREBUILT="
	opt/Signal/${MY_PN}
	opt/Signal/libnode.so
	opt/Signal/libffmpeg.so
"

RDEPEND="
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	x11-misc/xdg-utils
	dev-util/desktop-file-utils
	x11-libs/libXScrnSaver
	gnome-base/gconf
	!net-im/signal-desktop
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install(){
	insinto /
	doins -r *
	fperms +x /opt/Signal/${MY_PN}
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
