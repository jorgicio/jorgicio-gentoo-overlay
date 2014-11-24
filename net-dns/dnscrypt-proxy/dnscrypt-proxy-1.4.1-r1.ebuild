# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic systemd user git-2

DESCRIPTION="A tool for securing communications between a client and a DNS resolver"
HOMEPAGE="http://dnscrypt.org/"
RESTRICT="mirror"

LICENSE="ISC"
SLOT="0"
if [[ ${PV} == "9999" ]];then
	EGIT_REPO_URI="https://github.com/jedisct1/${PN}"
	KEYWORDS=""
else
	SRC_URI="http://download.dnscrypt.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
IUSE="+plugins ldns"
RDEPEND="dev-libs/libsodium
		ldns? ( net-libs/ldns )"

pkg_setup() {
	enewgroup dnscrypt
	enewuser dnscrypt -1 -1 /var/empty dnscrypt
}

src_configure() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi
	append-ldflags -Wl,-z,noexecstack
	econf --enable-nonblocking-random
	plugins? $(use_enable plugins)
}

src_install() {
	default

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}

	systemd_dounit "${FILESDIR}"/${PN}.service

	dodoc {AUTHORS,COPYING,INSTALL,NEWS,README,README.markdown,TECHNOTES,THANKS}
}
