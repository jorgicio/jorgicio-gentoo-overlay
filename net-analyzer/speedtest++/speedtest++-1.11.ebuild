# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Unofficial speedtest.net client using raw TCP for better accuracy"
HOMEPAGE="https://github.com/taganaka/SpeedTest"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="
	dev-libs/libxml2:2=
	dev-libs/openssl:0=
	net-misc/curl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SpeedTest-${PV}"

src_prepare() {
	sed -i -e "s#c++11#c++17#" CMakeLists.txt
	cmake_src_prepare
}

src_install() {
	cmake_src_install

	dosym SpeedTest /usr/bin/${PN}
}
