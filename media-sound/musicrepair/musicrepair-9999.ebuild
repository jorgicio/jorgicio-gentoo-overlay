# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5}} )

inherit distutils-r1

DESCRIPTION="A simple Python utility to fix mp3 metadata"
HOMEPAGE="https://pypi.python.org/pypi/spotipy https://github.com/lakshaykalbhor/MusicRepair"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/lakshaykalbhor/MusicRepair"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/spotipy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]

"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i -e "s/bs4/beautifulsoup4/" setup.py
	eapply_user
}
