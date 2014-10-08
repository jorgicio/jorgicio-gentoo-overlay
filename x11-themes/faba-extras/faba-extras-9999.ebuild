# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Extra icons for Faba Icons Theme."
HOMEPAGE="http://mokaproject.com"
SRC_URI=""
EGIT_REPO_URI="https://github.com/moka-project/faba-icon-theme-extras.git"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-themes/faba"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/icons
	doins -r ${WORKDIR}/${P}/Faba || die
}
