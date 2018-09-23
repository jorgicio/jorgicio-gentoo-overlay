# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Process-based network emulator"
HOMEPAGE="https://mininet.org"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/mininet/${PN}"
else
	SRC_URI="https://github.com/mininet/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Mininet"
SLOT="0"
IUSE="xhost"

DEPEND="
	${PYTHON_DEPS}
	app-shells/bash
	dev-python/networkx[${PYTHON_USEDEP}]
	sys-apps/net-tools[hostname]
	net-misc/iputils
	sys-apps/help2man
	dev-python/setuptools[${PYTHON_USEDEP}]
	net-misc/iperf:2
	net-misc/openvswitch[monitor]
"
RDEPEND="${DEPEND}
	xhost? ( x11-apps/xhost )
"

src_compile(){
	emake mnexec
	emake man
}

src_install(){
	distutils-r1_src_install
	dobin mnexec
	doman mn.1
	doman mnexec.1
}
