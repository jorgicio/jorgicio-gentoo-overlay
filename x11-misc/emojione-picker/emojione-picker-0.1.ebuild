# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Emoji picker based on icons by Emojione"
HOMEPAGE="https://github.com/gentakojima/emojione-picker-ubuntu"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-ubuntu-${PV}"
fi

LICENSE="CC-BY-4.0 GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-libs/libappindicator:3
"
RDEPEND="${DEPEND}"

src_prepare(){
	<install.sh sed 's/^\W*_INSTALL_PREFIX=.*/true/' | grep '^\W*_AUTOSTART_DIR=' -v | grep 'the program will be installed just for the current user.' -v | grep 'Press enter to install' -v | grep echo -v > install_for_pkgbuild.sh
	chmod +x install_for_pkgbuild.sh
	default
}

src_install(){
	_INSTALL_PREFIX="${D}/usr" _AUTOSTART_DIR="${D}/etc/xdg/autostart" ./install_for_pkgbuild.sh
}
