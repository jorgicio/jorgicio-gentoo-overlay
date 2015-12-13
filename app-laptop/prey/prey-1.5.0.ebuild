# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"
SRC_URI="https://github.com/${PN}/${PN}-node-client/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	virtual/cron
	net-libs/nodejs[npm]
	dev-libs/openssl
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

S="${WORKDIR}/${PN}-node-client-${PV}"

src_install(){
	npm install -g --prefix="${D}/usr"
	make_desktop_entry 'prey config gui' "Prey Configuration" ${PN} "System;Monitor"
	insinto /etc/cron.d
	insopts -m644
	doins "${FILESDIR}/prey.cron"
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png
}

pkg_postinst(){
	prey config hooks post_install
	ewarn "Don't forget add your user to the group prey (as root):"
	ewarn "gpasswd -a username prey"
}
