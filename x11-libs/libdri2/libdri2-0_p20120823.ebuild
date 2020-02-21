# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xorg-3

DESCRIPTION="Library for the DRI2 extension to the X Window System"
if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/robclark/${PN}.git"
	KEYWORDS=""
else
	COMMIT="4f1eef3183df2b270c3d5cbef07343ee5127a6a4"
	SRC_URI="https://github.com/robclark/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libdrm
	x11-base/xorg-proto
"
RDEPEND="${DEPEND}"

src_prepare(){
	default
	eautoreconf
}
