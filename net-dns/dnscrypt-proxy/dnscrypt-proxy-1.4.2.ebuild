# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic systemd user ${GIT_ECLASS}

DESCRIPTION="A tool for securing communications between a client and a DNS resolver"
HOMEPAGE="http://dnscrypt.org/"
RESTRICT="mirror"

LICENSE="ISC"
SLOT="0"
if [[ ${PV} == "9999" ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/jedisct1/${PN}"
	KEYWORDS=""
else
	SRC_URI="http://download.dnscrypt.org/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
IUSE="+plugins ldns systemd"
RDEPEND="dev-libs/libsodium
		ldns? ( net-libs/ldns )
		systemd? ( sys-apps/systemd )"

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

	if use systemd; then
		systemd_dounit "${FILESDIR}"/${PN}.service
	fi

	dodoc {AUTHORS,COPYING,INSTALL,NEWS,README,README.markdown,TECHNOTES,THANKS}
}
