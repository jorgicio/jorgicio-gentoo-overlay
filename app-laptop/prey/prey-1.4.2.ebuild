# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user git-r3 systemd

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/${PN}/${PN}-node-client"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="systemd"

DEPEND="
	virtual/cron
	net-libs/nodejs[npm]
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
	use systemd && systemd_dounit "${FILESDIR}/prey-agent.service"
	use !systemd && doinitd "${FILESDIR}/prey-agent"
}

pkg_postinst(){
	elog "Doing the post-installation hooks..."
	prey config hooks post_install
}
