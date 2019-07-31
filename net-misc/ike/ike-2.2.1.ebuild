# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils desktop systemd

DESCRIPTION="Shrew soft VPN Client"
HOMEPAGE="http://www.shrew.net/"
SRC_URI="http://www.shrew.net/download/${PN}/${P}-release.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap nat systemd"

COMMON_DEPEND="dev-libs/libedit
	dev-libs/openssl
	ldap? ( net-nds/openldap )"

DEPEND="${COMMON_DEPEND}
	>=sys-devel/bison-2.3
	sys-devel/flex"

RDEPEND="${COMMON_DEPEND}"

DOCS="CONTRIB.TXT README.TXT TODO.TXT"

S="${WORKDIR}/${PN}"

src_prepare(){
	sed -i -e 's|define "parser_class_name"|define parser_class_name|' \
		source/iked/conf.parse.yy || die
	has_version ">=dev-libs/openssl-1.1.0:0" && PATCHES=( "${FILESDIR}/${PN}-openssl-1.1.0.patch" )
	cmake-utils_src_prepare
}

src_configure(){
	#QTGUI disabled because it uses QT4
	mycmakeargs=(
		-DLDAP=$(usex ldap)
		-DNATT=$(usex nat)
		-DLIBDIR=/usr/$(get_libdir)
		-DQTGUI=NO
	)
	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	use systemd && systemd_dounit "${FILESDIR}"/iked.service
}

pkg_postinst() {
	elog "a default configuration for the IKE Daemon"
	elog "is stored in /etc/ike/iked.conf.sample"
}
