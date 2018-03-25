# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit bzr distutils-r1

DESCRIPTION="A simple indicator for controlling a synaptics touchpad"
HOMEPAGE="https://launchpad.net/touchpad-indicator"
SRC_URI=""
EBZR_REPO_URI="https://code.launchpad.net/~lorenzo-carbonell/${PN}/${PV:0:3}"
EBZR_BRANCH="${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/polib[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-libs/libappindicator:3
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyudev[pygobject,${PYTHON_USEDEP}]
	x11-apps/xinput
	x11-libs/libnotify
	x11-drivers/xf86-input-synaptics
"

src_prepare(){
	mv extras-touchpad-indicator.desktop.in touchpad-indicator.desktop.in
	mv data/extras-touchpad-indicator.desktop data/touchpad-indicator.desktop
	find . -type f -exec \
		sed -i -e 's:/opt/extras.ubuntu.com/touchpad-indicator:/usr:g' \
				-e 's:locale-langpack:locale:g' \
				-e 's:extras-touchpad-indicator:touchpad-indicator:g' '{}' \;
	eapply_user
}
