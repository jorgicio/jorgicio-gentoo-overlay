# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils user

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"

SRC_URI="
	x86? ( https://github.com/${PN}/${PN}-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x86.zip )
	amd64? ( https://github.com/${PN}/${PN}-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x64.zip )"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"

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

QA_PRESTRIPPED="
	opt/${PN}-node-client/bin/node
	opt/${PN}-node-client/node_modules/sqlite3/lib/binding/node-v46-linux-ia32/node_sqlite3.node
	opt/${PN}-node-client/node_modules/sqlite3/lib/binding/node-v46-linux-x64/node_sqlite3.node
	opt/${PN}-node-client/lib/agent/actions/wipe/linux/wipe-linux
"

src_prepare(){
	default
	sed -i "s#dir=\"\$dir/\$rel\"#dir=\"\$rel\"#" "bin/prey"
	sed -i "s#auto\_update\ =\ true#auto\_update\ =\ false#" "prey.conf.default"
}

src_install(){
	insinto /opt/${PN}-node-client
	doins -r *
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	fperms +x /opt/${PN}-node-client/bin/node
	fperms +x /opt/${PN}-node-client/bin/${PN}
	fperms +x /opt/${PN}-node-client/bin/${PN}-user
	doinitd "${FILESDIR}/${PN}-agent"
	exeinto /usr/bin
	newexe "${FILESDIR}/${PN}-bin" "${PN}"
}

pkg_postinst(){
	prey config hooks post_install >/dev/null
	gpasswd -a prey video >/dev/null
	elog "Don't forget add your user to the group prey (as root):"
	elog "gpasswd -a username prey"
	elog "After that, you must run the prey-agent daemon."
}

pkg_prerm(){
	prey config hooks pre_uninstall
	userdel prey
}
