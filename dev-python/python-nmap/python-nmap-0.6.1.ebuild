# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1

DESCRIPTION="A Python library which helps in using the nmap port scanner"
HOMEPAGE="http://xael.org/pages/python-nmap.html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-analyzer/nmap"
RDEPEND="${DEPEND}"
