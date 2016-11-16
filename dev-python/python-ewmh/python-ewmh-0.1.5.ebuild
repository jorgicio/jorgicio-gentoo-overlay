# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 python3_5 )

inherit distutils-r1

MY_PN="ewmh"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python implementation of EWMH (Extended Window Manager Hints)"
HOMEPAGE="https://github.com/parkouss/pyewmh"
SRC_URI="mirror://pypi/e/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~arm ~ppc64"
IUSE=""

DEPEND="dev-python/python-xlib[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"
