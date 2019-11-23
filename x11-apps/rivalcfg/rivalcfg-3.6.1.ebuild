# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1 udev

DESCRIPTION="SteelSeries Rival gaming configuration tool"
HOMEPAGE="https://github.com/flozz/rivalcfg"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="http://github.com/flozz/rivalcfg/archive/v${PV}.tar.gz -> ${P}.tar.gz"
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

PATCHES=( "${FILESDIR}/${PN}-remove-udev-rules-install.patch" )

src_install(){
	distutils-r1_src_install
	udev_dorules ${PN}/data/99-steelseries-rival.rules
}

pkg_postinst(){
	udev_reload
}
