# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic git-r3

DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/kenorb-contrib/tg"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="+lua +json libressl"
EGIT_REPO_URI="${HOMEPAGE}"

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl )
	dev-libs/libevent
	lua? ( dev-lang/lua:0 )
	json? ( dev-libs/jansson )"

RDEPEND="${DEPEND}"

src_configure() {
	append-cflags $(test-flags-CC -Wno-cast-function-type)
	econf \
		$(use_enable lua liblua ) \
		$(use_enable json )
}

src_install() {
	dobin bin/${PN}
	insinto /etc/${PN}
	newins tg-server.pub server.pub
}
