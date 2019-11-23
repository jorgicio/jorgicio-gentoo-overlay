# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit flag-o-matic python-r1

DESCRIPTION="Command line interface client for Telegram"
HOMEPAGE="https://github.com/vysheng/tg"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
IUSE="+lua +json libressl"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	TGL_COMMIT="b3dcce35110f5c995366318c2886065287815d09"
	TL_PARSER_COMMIT="ec8a8ed7a4f22428b83e21a9d3b5815f7a6f3bd9"
	SRC_URI="
		${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/vysheng/tgl/archive/${TGL_COMMIT}.tar.gz -> tgl-20150514.tar.gz
		https://github.com/vysheng/tl-parser/archive/${TL_PARSER_COMMIT}.tar.gz -> tl-parser-20141119.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/tg-${PV}"
fi

DEPEND="sys-libs/zlib
	sys-libs/readline
	dev-libs/libconfig
	!libressl? ( dev-libs/openssl )
	libressl? ( dev-libs/libressl )
	dev-libs/libevent
	lua? ( dev-lang/lua )
	json? ( dev-libs/jansson )"

RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

if [[ ${PV} != 9999 ]];then
	src_prepare(){
		cp -r ../tgl-${TGL_COMMIT}/* tgl
		cp -r ../tl-parser-${TL_PARSER_COMMIT}/* tgl/tl-parser
		PATCHES=( "${FILESDIR}/${P}-assertion-issue.patch" )
		default_src_prepare
	}
fi

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
