# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Official icon theme from the Numix project."
HOMEPAGE="https://numixproject.org"

if [[ ${PV} == *99999999 ]] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/numixproject/${PN}.git"
	KEYWORDS=""
else
	MY_PV="${PV:2:2}-${PV:4:2}-${PV:6:2}"
	SRC_URI="https://github.com/numixproject/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/icons
	doins -r Numix Numix-Light
	dodoc readme.md
	insinto /usr/share/licenses/${PN}
	doins license
}
