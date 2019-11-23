# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )
inherit distutils-r1 git-r3

DESCRIPTION="An easy, fast lib to correctly password-protect your data"
HOMEPAGE="https://github.com/ofek/privy"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

if [[ ${PV} == 9999 ]];then
	KEYWORDS=""
else
	EGIT_COMMIT="2f753ac2ca319ede62290f6fdf75dadb3b8dced4"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0 MIT"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/argon2_cffi[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"

PATCHES=( "${FILESDIR}/${PN}-remove-tests-package.patch" )
