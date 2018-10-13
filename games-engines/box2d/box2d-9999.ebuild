# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

MY_PN=Box2D

inherit eutils git-r3

DESCRIPTION="Box2D is an open source physics engine written primarily for games."
HOMEPAGE="http://www.box2d.org"
EGIT_REPO_URI="https://github.com/erincatto/${MY_PN}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/freeglut
	app-arch/unzip"
DEPEND="${RDEPEND}
	dev-util/premake:5
"

src_prepare(){
	premake5 gmake
	default
}

src_compile(){
	emake -C Build
}
