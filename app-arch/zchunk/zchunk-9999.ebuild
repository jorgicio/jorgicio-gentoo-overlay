# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="File format designed for highly efficient deltas with good compression"
HOMEPAGE="https://github.com/zchunk/zchunk"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="
	app-arch/zstd
	net-misc/curl
"
RDEPEND="${DEPEND}"
