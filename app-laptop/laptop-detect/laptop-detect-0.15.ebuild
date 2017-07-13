# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils

DESCRIPTION="Laptop mode attempts to determine whether it is being run on a laptop."
HOMEPAGE="http://packages.qa.debian.org/l/laptop-detect.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/${PN}/${PN}_${PV}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~ppc ~ppc64 ~hppa"
IUSE=""

RDEPEND="sys-apps/dmidecode"
DEPEND="${RDEPEND}"

src_install() {
	newbin laptop-detect.in laptop-detect
	doman laptop-detect.1
	dodoc README
	insinto ${EPREFIX}/usr/share/licenses/${PN}/
	doins debian/copyright
}

