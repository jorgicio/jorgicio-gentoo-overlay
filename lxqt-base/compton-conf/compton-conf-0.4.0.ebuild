# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MIN_API="3.1.0"

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
	KEYWORDS="amd64 ~arm ~arm64 x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="
	x11-misc/compton
	>=dev-qt/qtcore-5.7.1:5
	dev-libs/libconfig
	lxqt-base/liblxqt:0=
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-util/lxqt-build-tools-0.5.0"
