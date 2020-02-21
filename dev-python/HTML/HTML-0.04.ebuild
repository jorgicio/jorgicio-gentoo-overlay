# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

MY_P="${PN}.py-${PV}"
DESCRIPTION="A Python module to easily generate HTML tables and lists"
HOMEPAGE="https://www.decalage.info/python/html"
SRC_URI="https://www.decalage.info/files/${MY_P}.zip"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${PYTHON_DEPS}"
S="${WORKDIR}/${MY_P}"
