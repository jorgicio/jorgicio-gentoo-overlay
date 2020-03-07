# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg-utils

DESCRIPTION="Free and opensource replacement for files copy dialogs."
HOMEPAGE="https://ultracopier.first-world.info"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alphaonex86/${PN}"
else
	SRC_URI="https://files.first-world.info/${PN}/${PV}/${PN}-src-${PV}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-src"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/qtchooser"
RDEPEND="${DEPEND}"

src_prepare() {
	find . -name '*.ts' -exec lrelease {} \;
	default
}

src_configure() {
	eqmake5
}

src_install() {
	default
	dobin ${PN}
	domenu resources/${PN}.desktop
	for size in 16 36 48 72 128; do
		newicon -s ${size} resources/${PN}-${size}x${size}.png ${PN}.png
	done
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
