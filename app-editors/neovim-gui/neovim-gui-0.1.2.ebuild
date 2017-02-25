# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1 eutils

DESCRIPTION="Simple nvim gui implemented using GTK"
HOMEPAGE="https://github.com/neovim/python-gui"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
	S="${WORKDIR}/python-gui-${PV}"
fi

LICENSE="LGPL-3.0"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=app-editors/neovim-0.1.3
	>=dev-python/click-3.0
	dev-python/pygobject:3
	"
RDEPEND="${DEPEND}"

pkg_postinst(){
	einfo "To run the GUI, the command is pynvim. Enjoy!"
}
