# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="An implementation of Extended Window Manager Hints, based on Xlib"
HOMEPAGE="https://github.com/parkouss/pyewmh https://pypi.python.org/pypi/ewmh"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/python-xlib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
