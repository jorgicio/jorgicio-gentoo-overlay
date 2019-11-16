# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} pypy )

inherit distutils-r1

DESCRIPTION="A Python framework for building analytical web applications"
HOMEPAGE="https://plot.ly/products/dash"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? ( dev-python/pytest-dash[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-compress[${PYTHON_USEDEP}]
	dev-python/flask-seasurf[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]"

python_test() {
	pytest
}
