# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Simple and secure HTTP server for Qt applications"
HOMEPAGE="https://nitroshare.net"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nitroshare/${PN}.git"
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/nitroshare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtcore:5"
RDEPEND="${DEPEND}"
PATCHES=( "${FILESDIR}/${PN}-cmake-libdir.patch" )

src_configure(){
	mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
	)
	cmake_src_configure
}
