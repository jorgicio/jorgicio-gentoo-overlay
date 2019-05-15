# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Port of the GTK Materia Theme for Plasma 5 desktop with additions and extras."
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/materia-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~*"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kvantum"

DEPEND=""
RDEPEND="
	${DEPEND}
	kde-plasma/plasma-desktop
	kvantum? ( x11-themes/kvantum )
"

src_prepare(){
	if use !kvantum; then
		sed -i -e "s#konsole Kvantum#konsole#" Makefile
		sed -i -e "/Kvantum/d" Makefile
	fi
	default_src_prepare
}

src_install(){
	PREFIX=/usr DESTDIR="${D}/" default_src_install
}
