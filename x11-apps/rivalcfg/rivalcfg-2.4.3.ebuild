# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1 eutils udev

DESCRIPTION="SteelSeries Rival gaming configuration tool"
HOMEPAGE="https://github.com/flozz/rivalcfg"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="http://github.com/flozz/rivalcfg/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="WTFPL-2"
SLOT="0"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPS}"
DEPEND="
	${COMMON_DEPEND}
	>=dev-python/pyudev-0.19.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare(){
	epatch ${FILESDIR}/${PN}-remove-udev-rules-install.patch
	eapply_user
}

src_install(){
	esetup.py install --root="${D}" --optimize=1
	udev_dorules ${PN}/data/99-steelseries-rival.rules
	dodoc doc/*
}

pkg_postinst(){
	udevadm trigger || die
}
