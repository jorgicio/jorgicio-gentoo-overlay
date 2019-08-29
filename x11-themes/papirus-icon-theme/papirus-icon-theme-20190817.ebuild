# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Papirus icon theme for GTK and KDE"
HOMEPAGE="https://git.io/papirus-icon-theme"

if [[ ${PV} == 99999999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}.git"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default_src_prepare
	cd ${S}
	for size in 16x16 22x22 24x24
	do
		rm -f Papirus/${size}/panel/clementine-panel{,-grey}.svg
	done
}

src_install() {
	default_src_install
	for size in 16x16 22x22 24x24 32x32 48x48 64x64
	do
		dosym firefox-aurora.svg /usr/share/icons/Papirus/${size}/apps/aurora.svg
		dosym firefox.svg /usr/share/icons/Papirus/${size}/apps/firefox-bin.svg
	done
}

pkg_preinst(){
	gnome2_icon_savelist
}

pkg_postinst(){
	gnome2_icon_cache_update
}

pkg_postrm(){
	gnome2_icon_cache_update
}
