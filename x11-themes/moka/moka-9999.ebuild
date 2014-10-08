# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Moka is a stylized Linux desktop icon set, and the titular icon theme of the Moka Project. They are designed to be clear, simple and consistent."
HOMEPAGE="http://mokaproject.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/moka-project/moka-icon-theme.git"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-themes/faba"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/icons
	doins -r ${WORKDIR}/${P}/Moka || die
}

pkg_postinst(){
	elog "Hi! Thanks for prefering Moka icons!"
	elog "Don't forget had installed Faba icons first!"
}
