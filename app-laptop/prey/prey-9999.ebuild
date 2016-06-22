# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils user git-r3

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"
EGIT_REPO_URI="https://github.com/${PN}/${PN}-node-client"
KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="
	virtual/cron
	>=net-libs/nodejs-0.6[npm]
	dev-libs/openssl
	dev-python/pygtk
	media-tv/xawtv
	sys-apps/net-tools
	|| ( media-gfx/scrot media-gfx/imagemagick )
	|| ( gnome-extra/zenity kde-base/kdialog )
	media-sound/mpg123
	media-sound/pulseaudio
	net-wireless/wireless-tools
	sys-apps/lsb-release
	"
RDEPEND="${DEPEND}"

src_install(){
	npm install -g --prefix="${D}/usr" || die "Installation failed"
	make_desktop_entry 'prey config gui' "Prey Configuration" ${PN} "System;Monitor"
	insinto ${EPREFIX}/etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	doicon ${FILESDIR}/${PN}.png
}

pkg_postinst(){
	prey config hooks post_install
	gpasswd -a prey video >/dev/null
	if [ -f ${EROOT}/etc/init.d/prey-agent ];then
		rm -v ${EROOT}/etc/init.d/prey-agent
		install -m755 ${FILESDIR}/prey-agent-9999 ${EROOT}/etc/init.d/prey-agent
	fi
	elog "Don't forget add your user to the group prey (as root):"
	elog "gpasswd -a username prey"
	elog "After that, you must run the prey-agent daemon."
}

pkg_prerm(){
	prey config hooks pre_uninstall
	userdel prey
}
