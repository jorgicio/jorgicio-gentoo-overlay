# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
REV="2"

inherit eutils

DESCRIPTION="Laptop mode attempts to determine whether it is being run on a laptop."
HOMEPAGE="http://packages.ubuntu.com/en/hardy/laptop-detect"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/l/${PN}/${PN}_${PV}ubuntu$REV.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/dmidecode"

S="${WORKDIR}/${PN}-${PV}ubuntu$REV"

src_unpack() {
	unpack ${A}
	cd ${S} && cp laptop-detect.in laptop-detect
}

src_install() {
	dosbin laptop-detect

	dodoc README
}

