# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils

DESCRIPTION="Libpurple (Pidgin) plugin for using a Telegram account"
HOMEPAGE="https://github.com/majn/telegram-purple"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	MY_P=${PN}_${PV}
	SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${MY_P}.orig.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+libwebp"

DEPEND="net-im/pidgin
		dev-libs/openssl
		sys-libs/glibc
		libwebp? ( media-libs/libwebp )
		"
RDEPEND="${DEPEND}"

src_configure(){
	econf \
		$(use_enable libwebp)
}

src_compile(){
	emake
}

src_install(){
	emake DESTDIR="${D}" install || die
}
