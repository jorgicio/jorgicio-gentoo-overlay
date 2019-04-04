# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="GUI configuration tool for the compton X composite manager"
HOMEPAGE="http://github.com/lxde/compton-conf"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~x86 ~amd64 ~ppc ~arm"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="
	x11-misc/compton
	dev-util/lxqt-build-tools
	dev-qt/qtcore:5
	dev-libs/libconfig
	lxqt-base/liblxqt:0=
"
RDEPEND="${DEPEND}"
