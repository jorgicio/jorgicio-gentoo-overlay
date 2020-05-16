# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A lightweight decompression library with support for rar, tar and zip archives"
HOMEPAGE="https://github.com/selmf/unarr"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	COMMIT="7fa227366e8a3ff83eae6f9734644f4d5f257f39"
	SRC_URI="https://github.com/selmf/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="7z"

DEPEND="
	sys-libs/zlib
	app-arch/bzip2
	app-arch/xz-utils
	7z? ( app-arch/p7zip )
"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		-DENABLE_7Z=$(usex 7z)
	)
	cmake_src_configure
}
