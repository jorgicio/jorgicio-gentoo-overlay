# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_PN=Box2D

CMAKE_MIN_VERSION=2.6
inherit cmake-utils

DESCRIPTION="Box2D is an open source physics engine written primarily for games."
HOMEPAGE="http://www.box2d.org"
SRC_URI="https://github.com/erincatto/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_PN}-${PV}/${MY_PN}

src_configure() {
	local mycmakeargs=(
		-DBOX2D_BUILD_SHARED=ON
		-DBOX2D_INSTALL=ON
		-DBOX2D_BUILD_EXAMPLES=OFF
		-DBOX2D_BUILD_STATIC=OFF
	)
	cmake-utils_src_configure
}
