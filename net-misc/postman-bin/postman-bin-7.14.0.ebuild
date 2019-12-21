# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.getpostman.com"
SRC_URI="
	amd64? ( https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-amd64.tar.gz )
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN^}/app"

src_prepare() {
	mv _Postman Postman
	default
}

src_install() {
	mkdir -p "${ED}/opt/${MY_PN}"
	cp -r . "${ED}/opt/${MY_PN}"
	newicon -s 128 resources/app/assets/icon.png ${MY_PN}.png
	dobin "${FILESDIR}/${MY_PN}"
	make_desktop_entry "postman" \
		"Postman" \
		 "postman" \
		 "Development" \
		 "Type=Application" \
		 "Categories=Development;IDE;" \
		 "Comment=Build, test, and document your APIs faster"
}
