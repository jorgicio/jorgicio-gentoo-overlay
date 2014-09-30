# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Laptop mode attempts to determine whether it is being run on a laptop."
HOMEPAGE="http://packages.qa.debian.org/l/laptop-detect.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/dmidecode"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S} && cp laptop-detect.in laptop-detect
}

src_install() {
	dobin laptop-detect
	doman laptop-detect.8
	dodoc README
	insinto /usr/share/licenses/${PN}/
	doins debian/copyright
}

