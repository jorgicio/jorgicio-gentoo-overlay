# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{6,7,8}} )
inherit distutils-r1

DESCRIPTION="A simple, cross-platform module for mouse and keyboard control"
HOMEPAGE="https://github.com/PyUserInput/PyUserInput"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	${PYTHON_DEPS}
	dev-python/python-xlib[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"
