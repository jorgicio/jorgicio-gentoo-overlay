# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Tracking software for asset recovery, now Node.js-powered"
HOMEPAGE="http://preyproject.com"

SRC_URI="
	x86? ( https://github.com/${PN}/${PN}-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x86.zip )
	amd64? ( https://github.com/${PN}/${PN}-node-client/releases/download/v${PV}/${PN}-linux-${PV}-x64.zip )"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd"
DEPEND="
	virtual/cron
	dev-libs/openssl
	media-tv/xawtv
	sys-apps/net-tools
	|| ( media-gfx/scrot media-gfx/imagemagick )
	|| ( gnome-extra/zenity kde-apps/kdialog )
	media-sound/mpg123
	media-sound/pulseaudio
	net-wireless/wireless-tools
	sys-apps/lsb-release
	acct-user/prey
	net-libs/nodejs"
RDEPEND="${DEPEND}
	systemd? ( sys-apps/systemd )"

QA_PRESTRIPPED="*"
QA_TEXTRELS="*"

src_prepare(){
	sed -i "s#dir=\"\$dir/\$rel\"#dir=\"\$rel\"#" "bin/prey"
	sed -i "s#auto\_update\ =\ true#auto\_update\ =\ false#" "prey.conf.default"
	default
}

src_install(){
	mkdir -p "${ED}/usr/$(get_libdir)/${PN}"
	cp -r . "${ED}/usr/$(get_libdir)/${PN}"
	insinto /etc/prey
	insopts -m644
	newins ${PN}.conf.default ${PN}.conf
	newsbin "${FILESDIR}/${PN}-bin" "${PN}"
}

pkg_postinst(){
	prey config hooks post_install >/dev/null
	if [[ -f "${EROOT}/etc/init.d/prey-agent" ]];then
		elog "Daemon for prey-agent found. Cleaning..."
		rm -f "${EROOT}/etc/init.d/prey-agent"
		install -m755 "${FILESDIR}/${PN}-agent" "${EROOT}/etc/init.d/prey-agent"
	fi
	elog "Daemon for OpenRC installed"
	gpasswd -a prey video >/dev/null
	einfo "Don't forget add your user to the group prey (as root):"
	einfo "gpasswd -a username prey"
	einfo "After that, you must run the prey-agent daemon."
}

pkg_prerm(){
	prey config hooks pre_uninstall
}
