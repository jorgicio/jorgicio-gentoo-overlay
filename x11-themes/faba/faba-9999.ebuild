# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Faba is a sexy and modern icon theme with Tango influences."
HOMEPAGE="http://mokaproject.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/moka-project/faba-icon-theme.git"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/icons
	doins -r ${WORKDIR}/${P}/Faba || die
}

pkg_postinst(){
	elog "Hi! Thanks for prefering Faba Icons."
	elog "If you want to use some other variants, such as Faba-Extra, Moka and Moka Mono,"
	elog "please, install this theme first. Thanks."
}
