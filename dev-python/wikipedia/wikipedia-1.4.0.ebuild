# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} pypy )

inherit distutils-r1

DESCRIPTION="Python library to support Wikipedia articles"
HOMEPAGE="https://github.com/goldsmith/wikipedia https://pypi.python.org/pypi/wikipedia/"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/goldsmith/wikipedia"
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

COMMON_DEPEND="${PYTHON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${DEPEND}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
