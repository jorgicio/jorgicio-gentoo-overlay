# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="https://nitroshare.net"
SRC_URI="https://launchpad.net/nitroshare/${PV:0:3}/${PV}/+download/${P}.tar.gz -> ${P}.tar"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="appindicator http mdns test"

RDEPEND="
	>=dev-qt/qtcore-5.1.0:5
	>=dev-qt/qtsvg-5.1.0:5
	>=dev-qt/qtnetwork-5.1.0:5
	x11-libs/libnotify
	http? ( net-libs/qhttpengine )
	mdns? ( net-dns/qmdnsengine )"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qttest-5.1.0:5 )"
BDEPEND=">=dev-qt/linguist-tools-5.1.0:5"

PATCHES=(
	"${FILESDIR}/${PN}-qt-5.11-compatibility.patch"
	"${FILESDIR}/${P}-fix-configure.patch"
)

src_configure(){
	local mycmakeargs=(
		-DBUILD_API=$(usex http ON OFF)
		-DBUILD_MDNS=$(usex mdns ON OFF)
		-DBUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
