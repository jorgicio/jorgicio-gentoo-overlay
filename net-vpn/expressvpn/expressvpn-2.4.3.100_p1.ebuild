# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 systemd unpacker

DESCRIPTION="Propietary VPN client for Linux"
HOMEPAGE="https://expressvpn.com"
BASE_URI="https://download.expressvpn.xyz/clients/linux"
SRC_URI="
	amd64? ( "${BASE_URI}/${PN}_${PV/_p/-}_amd64.deb" )
	arm? ( "${BASE_URI}/${PN}_${PV/_p/-}_armhf.deb" )
	x86? ( "${BASE_URI}/${PN}_${PV/_p/-}_i386.deb" )"

LICENSE="ExpressVPN"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
RESTRICT="mirror strip"
IUSE="systemd"

DEPEND="sys-apps/net-tools
	systemd? ( sys-apps/systemd )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_prepare() {
	rm -r _gpgbuilder ./etc || die
	mv usr/share/doc/expressvpn/changelog.gz .
	gunzip changelog.gz
	default
}

src_install() {
	mkdir -p "${ED}/usr/$(get_libdir)"
	cp -r ./usr/bin "${ED}/usr/"
	cp -r ./usr/sbin "${ED}/usr/"
	cp usr/lib/${PN}/libxvclient.so "${ED}/usr/$(get_libdir)"
	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/${P}" "${PN}"
	dodoc changelog
	doman usr/share/man/man1/${PN}.1
	newbashcomp usr/lib/${PN}/bash-completion ${PN}
	use systemd && systemd_dounit usr/lib/${PN}/${PN}.service
}

pkg_postinst() {
	echo
	elog "Thank you for prefering ExpressVPN."
	elog "You may consider to purchase a plan in"
	elog "https://expressvpn.com/order"
	echo
}
