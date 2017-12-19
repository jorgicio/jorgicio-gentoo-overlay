# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit distutils-r1

DESCRIPTION="Pythonic DBus library"
HOMEPAGE="https://github.com/LEW21/pydbus"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-2+"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
"
