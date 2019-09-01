# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-data}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Data files for Tremulous"
HOMEPAGE="http://tremulous.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	rm CC ChangeLog COPYING GPL ${MY_PN}.{exe,x86,xpm} tremded.x86 ${MY_P}-src.tar.gz || die
	default
}

src_install() {
	mkdir -p "${D}/opt/${MY_PN}"
	cp -r . "${D}/opt/${MY_PN}"
	find "${D}/opt/${MY_PN}" -type f -exec chmod 644 {} +
}
