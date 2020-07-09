# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Kick devices off your network by performing an ARP spoof attack"
HOMEPAGE="https://nikolaskama.me/kickthemoutproject"
SRC_URI="https://github.com/k4m4/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	<net-analyzer/scapy-2.4.3[${PYTHON_USEDEP}]
	dev-python/python-nmap[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( CHANGES.rst README.rst )

src_install(){
	for s in *.py; do
		python_foreach_impl python_doscript ${s}
	done
	default
}
