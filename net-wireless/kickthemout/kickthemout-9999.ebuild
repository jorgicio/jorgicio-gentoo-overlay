# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit git-r3 python-r1

DESCRIPTION="Kick devices off your network by performing an ARP spoof attack"
HOMEPAGE="https://nikolaskama.me/kickthemoutproject"
EGIT_REPO_URI="https://github.com/k4m4/${PN}"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/python-nmap[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( README.md )

src_install(){
	for s in *.py; do
		python_foreach_impl python_doscript ${s}
	done
	default
}
