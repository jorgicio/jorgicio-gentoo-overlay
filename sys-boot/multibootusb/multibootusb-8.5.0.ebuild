# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Boot multiple live Linux distros from an USB flash drive"
HOMEPAGE="http://multibootusb.org"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mbusb/multibootusb.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mbusb/multibootusb/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~x86-linux ~amd64 ~amd64-linux"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	sys-fs/mtools
	sys-apps/util-linux[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	sys-block/parted
	app-arch/p7zip
"
