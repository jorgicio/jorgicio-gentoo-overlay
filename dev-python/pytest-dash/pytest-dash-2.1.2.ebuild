# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} pypy )

inherit distutils-r1

DESCRIPTION="pytest fixtures to run Dash applications"
HOMEPAGE="https://pypi.org/project/pytest-dash"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
