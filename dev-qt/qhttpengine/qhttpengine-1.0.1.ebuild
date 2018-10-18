# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils
CMAKE_MIN_VERSION="3.2.0"

DESCRIPTION="Simple and secure HTTP server for Qt applications"
HOMEPAGE="https://nitroshare.net"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/nitroshare/${PN}.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 ~arm x86"
	SRC_URI="https://github.com/nitroshare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtcore:5"
RDEPEND="${DEPEND}"
