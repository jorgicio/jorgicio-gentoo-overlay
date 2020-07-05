# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A Material Design icon theme based on Paper Icon Theme"
HOMEPAGE="https://github.com/vinceliuice/vimix-icon-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	MY_PV="${PV//./-}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
RESTRICT="strip"

DEPEND="x11-themes/hicolor-icon-theme"
RDEPEND="${DEPEND}"

src_install() {
	mkdir -p "${ED}"/usr/share/icons

	./install.sh -a -d "${ED}"/usr/share/icons || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
