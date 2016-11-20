# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_COMPAT=( python2_{6,7} python3_{1,2,3,4,5} pypy )

inherit distutils-r1

DESCRIPTION="Python library to support Wikipedia articles"
HOMEPAGE="https://github.com/goldsmith/wikipedia http://pypi.python.org/pypi/wikipedia/"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/goldsmith/wikipedia"
	KEYWORDS=""
else
	MY_PN="wikipedia"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
	KEYWORDS="amd64 x86 ~arm ~ppc ~ppc64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
