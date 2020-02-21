# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Port of the GTK Materia Theme for Plasma 5 desktop with additions and extras."
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/materia-kde"

if [[ ${PV} == 99999999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="kvantum +plasma"

RDEPEND="
	plasma? ( kde-plasma/plasma-desktop:5 )
	kvantum? ( x11-themes/kvantum )
"

src_prepare(){
	if use !kvantum; then
		sed -i -e "s#konsole Kvantum#konsole#" Makefile
		sed -i -e "/Kvantum/d" Makefile
	fi
	if use !plasma; then
		sed -i -e "s#plasma yakuake#yakuake#" Makefile
		sed -i -e "/plasma/d" Makefile
	fi
	default_src_prepare
}

src_install(){
	PREFIX=/usr DESTDIR="${D}/" default_src_install
}

pkg_postinst() {
	if has '>x11-themes/materia-theme-20190315'; then
		echo
		ewarn "It looks you have a materia-theme older than 20190315".
		ewarn "This version of materia-kde has compatibility only with"
		ewarn "Materia GTK 20190315. Please, don't open an issue about"
		ewarn "newest upstream color changes, because we don't like new colors."
		echo
	fi
}
