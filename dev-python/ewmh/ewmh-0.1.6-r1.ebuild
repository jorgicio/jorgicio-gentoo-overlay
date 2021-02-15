# Copyright 1999-2021 Jorgigio Gentoo Overlay Fork Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="An implementation of Extended Window Manager Hints, based on Xlib"
HOMEPAGE="https://github.com/parkouss/pyewmh https://pypi.python.org/pypi/ewmh"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"

RDEPEND="dev-python/python-xlib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
