# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A Python framework for building analytical web applications"
HOMEPAGE="https://plot.ly/dash"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/dash-core-components[${PYTHON_USEDEP}]
	dev-python/dash-html-components[${PYTHON_USEDEP}]
	dev-python/dash-renderer[${PYTHON_USEDEP}]
	dev-python/dash-table[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-compress[${PYTHON_USEDEP}]
	dev-python/flask-seasurf[${PYTHON_USEDEP}]
	>=dev-python/plotly-2.0.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	test? ( dev-python/pytest-dash[${PYTHON_USEDEP}] )"

python_test() {
	pytest
}
