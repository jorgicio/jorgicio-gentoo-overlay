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
	SRC_URI="https://github.com/selmf/${PN}/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	sys-libs/zlib
	app-arch/bzip2
	app-arch/xz-utils
"
RDEPEND="${DEPEND}"
