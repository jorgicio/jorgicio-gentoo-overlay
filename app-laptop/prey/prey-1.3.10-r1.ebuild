# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"
SRC_URI="
	x86? ( https://s3.amazonaws.com/${PN}-releases/node-client/${PV}/${PN}-linux-${PV}-x86.zip )
	amd64? ( https://s3.amazonaws.com/${PN}-releases/node-client/${PV}/${PN}-linux-${PV}-x64.zip )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
		virtual/cron
		net-libs/nodejs
		dev-python/pygtk
		media-tv/xawtv
        sys-apps/net-tools
		|| ( media-gfx/scrot media-gfx/imagemagick )
		app-laptop/laptop-detect
		|| ( gnome-extra/zenity kde-base/kdialog )
		media-sound/mpg123
		media-sound/pulseaudio
		net-wireless/wireless-tools
		sys-apps/lsb-release
		"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_prepare(){
	epatch "${FILESDIR}/${PN}-node-client.patch"
}

src_install(){
	insinto /opt/${PN}
	insopts -m755
	doins -r lib
	doins -r node_modules
	insinto /opt/${PN}
	insopts -m644
	doins package.json
	doins ${PN}.conf.default
	exeinto /opt/${PN}/bin
	doexe "${S}"/bin/${PN}
	insinto /usr/share/pixmaps
	insopts -m644
	doins "${S}"/lib/conf/gui/pixmaps/${PN}.png
	make_desktop_entry 'prey config gui' "Prey Configuration" ${PN} "System;Monitor"
	insinto /etc/cron.d
	insopts -m644
	doins "${FILESDIR}/prey.cron"
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	exeinto /usr/bin/
	newexe ${FILESDIR}/${PN}.sh ${PN}
}
