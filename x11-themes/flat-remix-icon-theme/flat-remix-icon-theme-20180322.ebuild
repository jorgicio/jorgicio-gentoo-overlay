# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="A pretty simple icon theme, derived from Ultra-Flat-Icons, Paper and Flattr"
HOMEPAGE="http://drasite.com/flat-remix https://github.com/daniruiz/Flat-Remix"

if [[ ${PV} == *99999999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/daniruiz/Flat-Remix.git"
	KEYWORDS=""
	SRC_URI=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/daniruiz/Flat-Remix/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P//-icon-theme}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

