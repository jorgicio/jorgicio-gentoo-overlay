# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="LDraw parts library"
HOMEPAGE="https://www.ldraw.org"
SRC_URI="https://www.ldraw.org/library/updates/complete.zip -> ${P}.zip"

LICENSE="CC-BY-2.0 OPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_unpack() {
	einfo "Not unpacking, continue..."
}

src_install() {
	insinto /usr/share/${PN}
	newins "${DISTDIR}/${P}.zip" ${PN}.zip
}

pkg_postinst() {
	echo
	elog "Thanks for installing LDraw parts library."
	elog "You can use a Lego-inspired CAD program."
	elog "A recommended option is media-gfx/leocad."
	echo
}
