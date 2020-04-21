# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

TGL_COMMIT="57f1bc41ae13297e6c3e23ac465fd45ec6659f50"

DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/kenorb-contrib/tg"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="+lua +json libressl"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SRC_URI="
	${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${HOMEPAGE}l/archive/${TGL_COMMIT}.tar.gz -> ${PN}-tgl-20190203.tar.gz"

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl )
	dev-libs/libevent
	lua? ( dev-lang/lua:0 )
	json? ( dev-libs/jansson )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/tg-${PV}"

src_prepare() {
	rm -rf "${S}/tgl"
	mv "${WORKDIR}/tgl-${TGL_COMMIT}" "${S}/tgl" || die
	default
}

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
