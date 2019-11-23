# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7,8} )

inherit meson python-r1

DESCRIPTION="Simple lightweight frontend for youtube-dl"
HOMEPAGE="https://github.com/JannikHv/gydl"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-misc/youtube-dl[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
