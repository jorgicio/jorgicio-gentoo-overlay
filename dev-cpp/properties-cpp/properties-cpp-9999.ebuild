# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A very simple convenience library for handling properties and signals in C++11"
HOMEPAGE="https://launchpad.net/properties-cpp"

if [[ ${PV} == 9999 ]]; then
	inherit bzr
	SRC_URI=""
	KEYWORDS=""
	EBZR_REPO_URI="https://code.launchpad.net/~phablet-team/${PN}/trunk"
else
	MY_PV="${PV:0:5}+14.10.${PV:7:8}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${MY_PV}.orig.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="test"
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
	use !test && truncate -s 0 tests/CMakeLists.txt
	cmake-utils_src_prepare
}
