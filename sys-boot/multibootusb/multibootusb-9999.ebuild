# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Boot multiple live Linux distros from an USB flash drive"
HOMEPAGE="http://multibootusb.org"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mbusb/multibootusb.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/mbusb/multibootusb/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	sys-fs/mtools
	sys-apps/util-linux
	dev-python/six[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	sys-block/parted
	app-arch/p7zip
	sys-fs/udisks:2
"
