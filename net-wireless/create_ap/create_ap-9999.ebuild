# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Tool for creating an access point for sharing wireless network"
HOMEPAGE="https://github.com/oblique/create_ap"
EGIT_REPO_URI="https://github.com/oblique/create_ap"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="haveged systemd"

RDEPEND="net-wireless/hostapd
	net-misc/bridge-utils
	|| (
		net-misc/dhcp
		net-misc/dhcpcd
		net-misc/pump
	)
	net-dns/dnsmasq
	net-firewall/iptables
	sys-apps/iproute2
	sys-apps/util-linux
	net-wireless/iw"
DEPEND="${RDEPEND}
		systemd? ( sys-apps/systemd )
		haveged? ( sys-apps/haveged )"

src_install(){
	exeinto /usr/bin
	doexe ${PN}
	if use systemd; then
		insinto /usr/lib/systemd/system/
		doins ${PN}.service
	fi
}

pkg_postinst(){
	elog "You must have connected through an ethernet port to use this script!"
	if use !systemd; then
		elog "You must install with SystemD support to use the service!"
	fi
}
