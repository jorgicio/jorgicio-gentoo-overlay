# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Application to split, merge, rotate and mix PDF files"
HOMEPAGE="https://scarpetta.eu/pdfmixtool"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/scarpetta/${PN}"
else
	SRC_URI="https://gitlab.com/scarpetta/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	app-text/podofo:=
	app-text/qpdf:=
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
