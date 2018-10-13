# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="An engine to make games in an easy way with Python. Made in Argentina."
HOMEPAGE="http://pilas-engine.com.ar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hugoruscitti/${PN}"
	KEYWORDS=""
	SRC_URI=""
else
	SRC_URI="https://github.com/hugoruscitti/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPEND}
	games-engines/box2d
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-python/pygame[X,${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"
