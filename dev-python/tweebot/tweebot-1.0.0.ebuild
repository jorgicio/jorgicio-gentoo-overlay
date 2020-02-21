# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6,7,8}} )

inherit distutils-r1 versionator git-r3

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="A Python library to build Twitter bots over Tweepy library"
HOMEPAGE="https://github.com/caxap/tweebot"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="v${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

#RESTRICT="test" 	#missing a required dep frpm portage

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/tweepy[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]"

python_prepare() {
	# Required to avoid file collisions at install
	sed -e "s:find_packages():find_packages(exclude=['tests','tests.*']):" -i setup.py || die
	distutils-r1_python_prepare
}

python_test() {
	"${PYTHON}" -m tests || die "Tests failed"
}

python_install() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install
}
