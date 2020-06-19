# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Speedtest CLI by Ookla"
HOMEPAGE="https://speedtest.net"
BASE_URI="https://ookla.bintray.com/download/ookla-${P}"
SRC_URI="
	amd64? ( ${BASE_URI}-x86_64-linux.tgz )
	arm? ( ${BASE_URI}-arm-linux.tgz )
	arm64? ( ${BASE_URI}-aarch64-linux.tgz )
	x86? ( ${BASE_URI}-i386-linux.tgz )"

LICENSE="Ookla"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror strip"

RDEPEND="!net-analyzer/speedtest-cli"

S="${WORKDIR}"

DOCS="${PN}.md"

src_install() {
	dobin ${PN}
	doman ${PN}.5
	default
}
