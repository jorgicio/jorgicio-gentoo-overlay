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
IUSE="doc test tools xhost"

DEPEND="
	${PYTHON_DEPS}
	dev-python/networkx[${PYTHON_USEDEP}]
	sys-apps/net-tools[hostname]
	net-misc/iputils
	doc? ( sys-apps/help2man )
	dev-python/setuptools[${PYTHON_USEDEP}]
	net-misc/iperf:2
	net-misc/openvswitch
	dev-libs/libcgroup
"
RDEPEND="${DEPEND}
	|| (
		net-misc/netkit-telnetd
		net-misc/telnet-bsd
	)
	sys-process/procps
	tools? (
		net-misc/socat
		sys-process/psmisc
		net-misc/iperf
		x11-terms/xterm
		sys-apps/ethtool
	)
	xhost? ( x11-apps/xhost )
"

PATCHES=( "${FILESDIR}/${PN}-2.2.1-modify-sys-mount.patch" )

src_compile(){
	distutils-r1_src_compile
	emake mnexec
	emake man
}

src_install(){
	distutils-r1_src_install
	dobin mnexec
	doman mn.1
	doman mnexec.1
	use doc && dodoc
}
