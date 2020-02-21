# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit flag-o-matic git-r3 python-r1

DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/vysheng/tg"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="+lua +json libressl"
EGIT_REPO_URI="${HOMEPAGE}"
SRC_URI=""

if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	!libressl? ( <dev-libs/openssl-1.1.0:0 )
	libressl? ( dev-libs/libressl )
	dev-libs/libevent
	lua? ( dev-lang/lua )
	json? ( dev-libs/jansson )"

RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

PATCHES=(
	"${FILESDIR}/${P}-assertion-issue.patch"
)

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
