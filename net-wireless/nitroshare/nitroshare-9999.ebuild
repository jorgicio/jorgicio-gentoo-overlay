# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Network File Transfer Application"
HOMEPAGE="https://nitroshare.net"
EGIT_REPO_URI="https://github.com/${PN}/${PN}-desktop"

LICENSE="MIT"
SLOT="0"
IUSE="appindicator http mdns test"

DEPEND="
	>=dev-qt/qtcore-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5
	>=dev-qt/qtnetwork-5.4.0:5
	>=dev-qt/linguist-tools-5.4.0:5
	x11-libs/libnotify
	http? ( net-libs/qhttpengine )
	mdns? ( net-dns/qmdnsengine )
	test? ( >=dev-qt/qttest-5.4.0:5 )
	"

RDEPEND="${DEPEND}
	appindicator? (
		x11-libs/gtk+:2
		dev-libs/libappindicator:2
	)
"

PATCHES=( "${FILESDIR}/${PN}-cmake-libdir.patch" )

src_configure(){
	local mycmakeargs=(
		-DBUILD_API=$(usex http ON OFF)
		-DBUILD_MDNS=$(usex mdns ON OFF)
		-DBUILD_TESTS=$(usex test ON OFF)
	)
	cmake-utils_src_configure
}
