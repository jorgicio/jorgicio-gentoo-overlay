# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils user

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"
SRC_URI="
	x86? ( https://github.com/prey/prey-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x86.zip )
	amd64? ( https://github.com/prey/prey-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x64.zip )
"
KEYWORDS="x86 amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
RESTRICT="mirror"

DEPEND="
	virtual/cron
	>=net-libs/nodejs-0.6
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

src_prepare(){
	rm bin/node
	epatch "${FILESDIR}/prey-node-client.patch"
	eapply_user
}

src_install(){
	insinto /opt/${PN}-node-client
	doins -r *
	make_desktop_entry 'prey config gui' "Prey Configuration" ${PN} "System;Monitor"
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	doicon ${FILESDIR}/${PN}.png
	dosym /opt/${PN}-node-client/bin/${PN} ${EPREFIX}/usr/bin/${PN}
	fperms +x /opt/${PN}-node-client/bin/${PN}
}

pkg_postinst(){
	/opt/prey-node-client/bin/prey config hooks post_install >/dev/null
	gpasswd -a prey video >/dev/null
	if [ -f ${EROOT}/etc/init.d/prey-agent ];then
		rm -v ${EROOT}/etc/init.d/prey-agent
		install -m755 ${FILESDIR}/prey-agent ${EROOT}/etc/init.d
	fi
	elog "Don't forget add your user to the group prey (as root):"
	elog "gpasswd -a username prey"
	elog "After that, you must run the prey-agent daemon."
}

pkg_prerm(){
	/opt/prey-node-client/bin/prey config hooks pre_uninstall
	userdel prey
}
