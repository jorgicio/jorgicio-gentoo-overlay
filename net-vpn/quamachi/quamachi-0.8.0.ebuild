# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-any-r1

DESCRIPTION="A QT5-based Hamachi GUI for Linux"
HOMEPAGE="http://Quamachi.Xavion.name"
SRC_URI="mirror://sourceforge/${PN}/${PN^}-${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(python_gen_any_dep 'dev-python/PyQt5[${PYTHON_USEDEP},network,gui]')
	>=net-vpn/logmein-hamachi-2.1"
RDEPEND="${DEPEND}
	net-misc/tigervnc
"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${PN^}/Build"

python_check_deps(){
	has_version "dev-python/PyQt5[${PYTHON_USEDEP}]"
}

pkg_setup(){
	python-any-r1_pkg_setup
}

src_prepare(){
	sed -i -e "s#make#\${MAKE}#" Makefile || die
	default_src_prepare
}

src_install(){
	emake DESTDIR="${D}" Sys-SBin="/usr/bin" install
}

pkg_postinst(){
	echo
	elog "Thanks for using Quamachi."
	elog "Optionally, you can install some frontends such as:"
	elog "net-misc/putty, for SSH"
	elog "net-analyzer/mtr, for ping"
	elog "Some terminal you like"
	elog "Some sudo frontend, like gksu or kdesudo"
	elog "net-misc/vinagre, for VNC support"
	echo
}
