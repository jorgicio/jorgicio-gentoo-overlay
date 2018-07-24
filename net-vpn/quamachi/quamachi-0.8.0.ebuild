# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-r1 eutils

DESCRIPTION="A QT5-based Hamachi GUI for Linux"
HOMEPAGE="http://Quamachi.Xavion.name"
SRC_URI="mirror://sourceforge/${PN}/${PN^}-${PV}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt5[${PYTHON_USEDEP},network,gui]
	>=net-vpn/logmein-hamachi-2.1
"
RDEPEND="${DEPEND}
	net-misc/putty
	net-analyzer/mtr
	|| ( x11-libs/gksu kde-apps/kdesu kde-frameworks/kdesu kde-apps/kdesudo )
	net-misc/vinagre
"

S="${WORKDIR}/${PN^}/Build"

src_prepare(){
	local externals_dir="${S}/../Externals"
	echo "mate-terminal -e" >> ${externals_dir}/Terminal.txt
	echo "gksu" >> ${externals_dir}/SUdo.txt
	eapply_user
}

src_install(){
	emake DESTDIR="${D}" Sys-SBin="/usr/bin" install
}
