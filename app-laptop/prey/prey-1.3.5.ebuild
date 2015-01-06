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
		app-shells/bash
		virtual/cron
		net-libs/nodejs[npm]
		dev-python/pygtk
		|| ( net-misc/curl net-misc/wget )
        dev-perl/IO-Socket-SSL
        dev-perl/Net-SSLeay
        sys-apps/net-tools
		|| ( media-gfx/scrot media-gfx/imagemagick )
		app-laptop/laptop-detect
		|| ( media-video/mplayer[encode,jpeg,v4l] media-tv/xawtv )
		sys-apps/traceroute
		|| ( gnome-extra/zenity kde-base/kdialog )
		media-sound/mpg123
		media-sound/pulseaudio
		sys-apps/iproute2
		"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_install(){
	insinto /opt/${PN}
	insopts -m755
	doins -r lib
	doins -r node_modules
	doins package.json
	insinto /opt/${PN}/bin
	doins "${S}"/bin/${PN}
	fperms 755 /opt/${PN}/bin/${PN}
	insinto /usr/share/pixmaps
	insopts -m644
	doins "${S}"/lib/conf/gui/pixmaps/${PN}.png
	make_desktop_entry 'prey conf gui' "Prey Configuration" ${PN} "System;Monitor"
	insinto /etc/cron.d
	insopts -m644
	doins "${FILESDIR}/prey.cron"
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	exeinto /usr/bin/
	newexe ${FILESDIR}/${PN}.sh ${PN}
}
