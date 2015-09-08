# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Fight Flash Fraud, or Fight Fake Flash"
HOMEPAGE="http://oss.digirati.com.br/f3/"
SRC_URI="https://github.com/AltraMayor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin f3write
	dobin f3read
	dodoc README
}
