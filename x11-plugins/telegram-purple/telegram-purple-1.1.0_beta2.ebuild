# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="Libpurple (Pidgin) plugin for using a Telegram account"
HOMEPAGE="https://github.com/majn/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="v${MY_PV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+libwebp"

DEPEND="net-im/pidgin
		dev-libs/openssl
		sys-libs/glibc
		libwebp? ( media-libs/libwebp )
		"
RDEPEND="${DEPEND}"

src_compile(){

	econf $(use_enable libwebp) || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install || die
}
