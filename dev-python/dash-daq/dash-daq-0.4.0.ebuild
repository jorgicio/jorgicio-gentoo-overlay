# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Control componentes for Dash"
HOMEPAGE="https://plot.ly/dash"
SRC_URI="https://github.com/plotly/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/dash[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	sys-apps/yarn"

DEPEND="
	${RDEPEND}
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	pytest
}
