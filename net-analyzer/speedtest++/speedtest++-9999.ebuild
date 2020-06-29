# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Unofficial speedtest.net client using raw TCP for better accuracy"
HOMEPAGE="https://github.com/taganaka/SpeedTest"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/libxml2:2=
	dev-libs/openssl:0=
	net-misc/curl"
RDEPEND="${DEPEND}"

src_install() {
	cmake_src_install

	dosym SpeedTest /usr/bin/${PN}
}
