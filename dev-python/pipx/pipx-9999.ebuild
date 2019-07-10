# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy pypy3 python{2_7,3_{6,7}} )
inherit distutils-r1

DESCRIPTION="Execute binaries from Python packages in isolated environments"
HOMEPAGE="https://pipxproject.github.io/pipx/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pipxproject/${PN}"
else
	SRC_URI="https://github.com/pipxproject/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~amd64-fbsd ~amd64-linux ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-linux"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/userpath[${PYTHON_USEDEP}]
	test? (
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/mkdocs[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"
