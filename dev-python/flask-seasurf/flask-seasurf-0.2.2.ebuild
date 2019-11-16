# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} pypy )

inherit distutils-r1

MY_PN="Flask-SeaSurf"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An updated cross-site forgery protection extension for Flask"
HOMEPAGE="https://pypi.org/project/Flask-SeaSurf"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_test() {
	pytest
}
