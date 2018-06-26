# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Application launcher for Linux"
HOMEPAGE="https://ulauncher.io"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/Ulauncher/${PN^}.git"
else
	SRC_URI="https://github.com/Ulauncher/${PN^}/releases/download/${PV}.${PR}/${PN}_${PV}.${PR}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

PYTHON_REQ_USE="sqlite"

DEPEND="
	${PYTHON_DEPS}
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/python-levenshtein[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	dev-libs/gobject-introspection[${PYTHON_USEDEP}]
	dev-libs/libappindicator:3
	dev-libs/keybinder:3[python,${PYTHON_USEDEP}]
	net-libs/webkit-gtk:4/37
"

src_prepare(){
	find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python *$=\1python2='
	distutils-r1-src_prepare
}

src_install(){
	domenu build/share/applications/${PN}.desktop
	distutils-r1-src_install
}
