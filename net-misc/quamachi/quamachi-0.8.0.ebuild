# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{3,4,5} )

inherit python-r1 eutils

DESCRIPTION="A QT4-based Hamachi GUI for Linux"
HOMEPAGE="http://Quamachi.Xavion.name"
SRC_URI="mirror://sourceforge/Quamachi/${PV}/Quamachi-${PV}.tar.bz2"
RESTRICT="mirror"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/PyQt4[X,${PYTHON_USEDEP}]
	net-misc/logmein-hamachi
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Quamachi-${PV}/Build"

src_compile(){
	emake DESTDIR="${D}"
}

src_install(){
	emake DESTDIR="${D}" Sys-SBin="/usr/bin" install
}
