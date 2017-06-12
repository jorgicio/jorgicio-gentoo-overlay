# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="A lightweight decompression library with support for rar, tar and zip archives"
HOMEPAGE="http://github.com/zeniko/unarr"
SRC_URI="https://raw.githubusercontent.com/selmf/${PN}/master/CMakeLists.txt"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

DEPEND="
	sys-libs/zlib
	app-arch/bzip2
"
RDEPEND="${DEPEND}"

src_prepare(){
	cp ${DISTDIR}/CMakeLists.txt . || die
	eapply_user
}
