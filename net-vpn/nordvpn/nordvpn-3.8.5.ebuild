# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info unpacker

DESCRIPTION="NordVPN CLI tool for Linux"
HOMEPAGE="https://nordvpn.com"
BASE_URI="https://repo.nordvpn.com/deb/${PN}/debian/pool/main"
SRC_URI="
	amd64? ( ${BASE_URI}/${P/-/_}_amd64.deb )
	arm? ( ${BASE_URI}/${P/-/_}_armhf.deb )
	arm64? ( ${BASE_URI}/${P/-/_}_arm64.deb )
	x86? ( ${BASE_URI}/${P/-/_}_i386.deb )"

LICENSE="NordVPN"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="nordlynx systemd"
RESTRICT="mirror strip"

RDEPEND="
	dev-libs/libxslt[crypt]
	net-firewall/iptables
	sys-apps/iproute2[iptables]
	sys-apps/net-tools
	sys-process/procps
	nordlynx? (
		net-vpn/wireguard-modules
		net-vpn/wireguard-tools
	)
	systemd? (
		sys-apps/systemd
	)"

S="${WORKDIR}"

pkg_pretend() {
	if use nordlynx && kernel_is -ge 5 6; then
		eerror "You enabled the nordlynx USE-flag and"
		eerror "have a kernel >= 5.6, so this is not needed"
		eerror "because the wireguard-modules built into the"
		eerror "kernel. Please, disable it."
	fi
}

src_prepare() {
	rm _gpgbuilder || die
	if use !systemd; then
		rm -rf usr/lib || die
	fi
	gunzip usr/share/doc/nordvpn/changelog.gz
	gunzip usr/share/man/man1/${PN}.1.gz
	mv usr/share/doc/nordvpn usr/share/doc/${P}
	rm -rf etc
	default
}

src_install() {
	mkdir -p "${ED}"
	cp -r . "${ED}"/
	use !systemd && doinitd "${FILESDIR}/${PN}d"
}

pkg_postinst() {
	echo
	elog "Thanks for installing the NordVPN client."
	elog "Don't forget to purchase your NordVPN plan in order to use the client."
	echo
}
