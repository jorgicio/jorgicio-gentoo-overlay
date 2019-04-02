# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xorg-3 git-r3

DESCRIPTION="Library for the DRI2 extension to the X Window System"
#HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="https://github.com/robclark/${PN}.git"
if [[ ${PV} == 99999999 ]];then
	KEYWORDS=""
else
	EGIT_COMMIT="4f1eef3183df2b270c3d5cbef07343ee5127a6a4"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
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
	default_src_prepare
	eautoreconf
}
