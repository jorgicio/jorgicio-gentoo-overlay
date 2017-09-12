# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Kick devices off your network by performing an ARP spoof attack"
HOMEPAGE="https://nikolaskama.me/kickthemoutproject"

if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/k4m4/${PN}"
else
	SRC_URI="https://github.com/k4m4/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/python-nmap[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_install(){
	insinto /usr/share/${PN}
	doins -r *
	dosbin "${FILESDIR}/${PN}"
}
