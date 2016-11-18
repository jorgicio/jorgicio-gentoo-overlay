# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} python3_{1,2,3,4,5} pypy )

inherit distutils-r1

MY_PN="wikipedia"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library to support Wikipedia articles"
HOMEPAGE="http://pypi.python.org/pypi/wikipedia/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~arm ~ppc ~ppc64"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
