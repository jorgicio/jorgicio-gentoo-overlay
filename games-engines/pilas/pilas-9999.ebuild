# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="An engine to make games in an easy way with Python. Made in Argentina."
HOMEPAGE="http://pilas-engine.com.ar"
EGIT_REPO_URI="https://github.com/hugoruscitti/${PN}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${PYTHON_DEPEND}
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-libs/box2d
	dev-python/pygame[X,${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	"
RDEPEND="${DEPEND}"
