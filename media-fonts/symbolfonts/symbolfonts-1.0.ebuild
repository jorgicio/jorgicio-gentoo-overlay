# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Symbol fonts used in Kingsoft office"
HOMEPAGE="http://wps-community.org/download/fonts/"
SRC_URI="http://wps-community.org/download/fonts/wps_symbol_fonts.zip"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/fonts/symbolfonts"
	doins *
}
