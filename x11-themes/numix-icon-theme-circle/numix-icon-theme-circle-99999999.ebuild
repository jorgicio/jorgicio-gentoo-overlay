# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Numix Circle icon theme"
HOMEPAGE="https://numixproject.org"

if [[ ${PV} == *99999999* ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/numixproject/${PN}.git"
	KEYWORDS=""
else
	MY_PV="${PV:2:2}-${PV:4:2}-${PV:6:2}"
	SRC_URI="https://github.com/numixproject/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86 arm"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-3.0+"
SLOT="0"

DEPEND="x11-themes/numix-icon-theme"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/icons
	doins -r Numix-Circle Numix-Circle-Light
	dodoc README.md
}
