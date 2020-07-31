# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 python-utils-r1

DESCRIPTION="Control componentes for Dash"
HOMEPAGE="https://plot.ly/dash"
SRC_URI="https://github.com/plotly/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="network-sandbox"

RDEPEND="
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	dev-python/dash[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

BDEPEND="sys-apps/yarn"

src_prepare() {
	# Fix sandbox issue
	addpredict "${BROOT}"/usr/local/share/.cache
	addpredict "${BROOT}"/usr/local/share/.yarn
	addpredict "${BROOT}"/usr/local/share/.yarnrc

	default
}

python_test() {
	pytest
}

src_compile() {
	python_setup

	rm yarn.lock package-lock.json

	yarn

	${EPYTHON} get_version_info.py

	yarn copy-lib

	dash-generate-components ./src/components dash_daq \
		-p package-info.json --r-prefix 'daq'

	distutils-r1_src_compile
}
