# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN=Box2D

CMAKE_MIN_VERSION=2.8
inherit cmake-utils eutils git-r3

DESCRIPTION="Box2D is an open source physics engine written primarily for games."
HOMEPAGE="http://www.box2d.org"
EGIT_REPO_URI="https://github.com/erincatto/${MY_PN}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/freeglut
	app-arch/unzip"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs="${mycmakeargs} -DBOX2D_BUILD_SHARED=ON"

	cmake-utils_src_configure
}
